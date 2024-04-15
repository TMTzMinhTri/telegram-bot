module Ngrok
  class NotFound < StandardError; end
  class FetchUrlError < StandardError; end
  class Error < StandardError; end

  class Tunnel
    class << self
      attr_reader :pid, :status, :ngrok_url_https

      def initialize(params = {})
        @params = { addr: 3001, timeout: 2, config: create_empty_config_file.path }.merge(params)
        @ngrok_url_https = params[:ngrok_url_https]
        @status ||= :stopped
      end

      def start(params = {})
        ensure_binary
        raise Ngrok::NotFound, 'Ngrok version >= 3 required' if pre_v3?

        initialize(params)
        if stopped?
          @params[:log] = @params[:log] ? File.open(@params[:log], 'w+') : Tempfile.new('ngrok')
          @pid = spawn("exec ngrok tunnel #{ngrok_exec_params}")
          at_exit { Ngrok::Tunnel.stop }
          ngrok_url_https
        end

        @status = :running
        @ngrok_url
      end

      def stop
        if running?
          Process.kill(9, @pid)
          @ngrok_url = @ngrok_url_https = @pid = nil
          @status = :stopped
        end
        @status
      end

      def running?
        @status == :running
      end

      def stopped?
        @status == :stopped
      end

      def addr
        @params[:addr]
      end

      def port
        return addr if addr.is_a?(Numeric)

        addr.split(':').last.to_i
      end

      def log
        @params[:log]
      end

      def subdomain
        @params[:subdomain]
      end

      def authtoken
        @params[:authtoken]
      end

      def inherited(_subclass)
        initialize
      end

      private

      def ngrok_exec_params
        exec_params = '--log=stdout --log-level=debug '
        exec_params << "--label #{@params[:label]} " if @params.key? :label
        exec_params << "--scheme=#{@params[:scheme]} " if @params.key? :scheme
        exec_params << "--region=#{@params[:region]} " if @params[:region]
        exec_params << "--host-header=#{@params[:host_header]} " if @params[:host_header]
        exec_params << "--authtoken=#{@params[:authtoken]} " if @params[:authtoken]
        exec_params << "--subdomain=#{@params[:subdomain]} " if @params[:subdomain]
        exec_params << "--hostname=#{@params[:hostname]} " if @params[:hostname]
        exec_params << "--inspect=#{@params[:inspect]} " if @params.key? :inspect
        exec_params << "--config=#{@params[:config]} #{@params[:addr]} > #{@params[:log].path}"
        exec_params << ' 2>&1' if @params[:redirect_stderr]

        exec_params
      end

      def ensure_binary
        @version = `ngrok version`
      rescue Errno::ENOENT
        raise Ngrok::NotFound, 'Ngrok binary not found'
      end

      def pre_v3?
        /^ngrok version [012]\./.match?(@version)
      end

      def create_empty_config_file
        tmp = Tempfile.new('ngrok_config-')
        tmp << 'version: 2"\n"'
        tmp.flush
        tmp.close

        tmp
      end
    end

    initialize
  end
end
