namespace :dotenv do
  desc 'Upload dotenv file'
  task :upload do
    on roles(:app) do
      upload!('.env', "#{shared_path}/.env")
    end
  end
end

