# encoding: utf-8

Adhearsion.config do |config|
  config.punchblock.platform  = :asterisk
  config.platform.environment = :development
end

Adhearsion.router do
  route 'default', LeakyController
end
