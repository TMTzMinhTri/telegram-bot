namespace :telegram do
  desc "Sync new telegram commands"

  task sync_commands: [:environment] do
    Telegram::SyncCommandService.call
  end
end
