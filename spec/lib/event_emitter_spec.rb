require 'spec_helper'

describe EventEmitter do
  context 'without any events' do
    it 'should not trigger any events' do
      expect(subject.trigger(:dne)).to eq([])
    end
  end

  context 'with events' do
    context 'with one event per key' do
      it 'should return only a single event' do
        subject.on :some_event do
          'Hello World!'
        end
        expect(subject.trigger(:some_event)).to eq(['Hello World!'])
      end
    end

    context 'with multiple events per key' do
      it 'should return multiple events' do
        subject.on(:some_event) { 'apple' }
        subject.on(:some_event) { 'bananna' }
        expect(subject.trigger(:some_event)).to eq(['apple', 'bananna'])
      end
    end
  end
end
