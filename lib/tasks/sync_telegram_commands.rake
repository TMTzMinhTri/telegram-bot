namespace :sync_telegram_commands do
  desc "Sync new telegram commands"

  task sync: [:environment] do
    Telegram::SyncCommandService.new.call
  end
end
