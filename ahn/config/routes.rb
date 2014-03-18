# encoding: utf-8

require 'call_controllers/leaky_controller'

Adhearsion.router do
  route 'default', LeakyController
end
