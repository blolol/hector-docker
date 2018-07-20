require 'logger'

require 'blolol/hector/identity_adapter'
require 'hector/jekyll'
require 'hector/secret_channels'

Hector.server_name = ENV.fetch('HECTOR_SERVER_NAME', 'blolol.irc')

STDOUT.sync = true
Hector.logger = Logger.new(STDOUT)
Hector.logger.level = ENV.fetch('HECTOR_LOG_LEVEL', 'info')

Hector.ssl_certificate_path = Hector.root.join('config/certificate_chain.pem').to_s
Hector.ssl_certificate_key_path = Hector.root.join('config/private_key.pem').to_s

Hector::Identity.adapter = Hector::JekyllIdentityAdapter.new([
  Hector::YamlIdentityAdapter.new(Hector.root.join('config/identities.yml')),
  Blolol::Hector::IdentityAdapter.new(api_key: ENV.fetch('BLOLOL_API_KEY'),
    api_secret: ENV.fetch('BLOLOL_API_SECRET'))
])

if ENV['HECTOR_MERCURY_SQS_QUEUE_URL']
  require 'hector/mercury'
  Hector::Mercury.aws_access_key_id = ENV.fetch('AWS_ACCESS_KEY_ID')
  Hector::Mercury.aws_secret_access_key = ENV.fetch('AWS_SECRET_ACCESS_KEY')
  Hector::Mercury.aws_sqs_queue_url = ENV.fetch('HECTOR_MERCURY_SQS_QUEUE_URL')
end
