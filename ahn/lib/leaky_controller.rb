# encoding: utf-8

class LeakyController < Adhearsion::CallController
  def run
    answer
    ask limit: 1
  end
end
