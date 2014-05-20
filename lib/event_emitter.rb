class EventEmitter
  attr_reader :events

  def initialize
    @events = Hash.new{|hash,key| hash[key] = [] }
  end
  def on(*events, &block)
    raise ArgumentError, 'Block not given' unless block_given?
    events.uniq.each do |key|
      @events[key] << block
    end
  end

  def trigger(event)
    events[event].map(&:call)
  end
end
