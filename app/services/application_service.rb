module ApplicationService
  def call(*args, &block)
    new(*args, &block).call
  end
end
