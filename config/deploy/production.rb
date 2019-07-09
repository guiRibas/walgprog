set :stage, :production

server '206.189.226.48', roles: %w[app web db], primary: true, user: 'deployer'
set :rails_env, 'production'
