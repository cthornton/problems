require 'spec_helper'

describe BinarySearchTree::Node do
  let(:node) { BinarySearchTree::Node.new('b', 'banana') }

  context 'with a single node' do
    describe '#find' do
      it 'should find a valid key' do
        expect(node.find 'b').to eq('banana')
      end

      it 'should support the ["key"] syntax' do
        expect(node['b']).to eq('banana')
      end

      it 'should return nil for a non-existing key' do
        expect(node['does-not-exist']).to be_nil
      end
    end

    describe '#size' do
      it 'should return 1 for a single node' do
        expect(node.size).to eq(1)
      end

      it 'should return the correct size for multiple nodes' do
        node['foo'] = 'bar'
        node['bar'] = 'baz'
        node['baz'] = 'biz'
        expect(node.size).to eq(4)
      end
    end

    describe '#insert' do
      let(:apple)   { BinarySearchTree::Node.new('a', 'apple') }
      let(:caramel) { BinarySearchTree::Node.new('c', 'caramel') }

      it 'should insert in the correct spots' do
        node.insert caramel
        node.insert apple
        expect(node.left).to eq(apple)
        expect(node.right).to eq(caramel)
      end

      it 'should support ["foo"] = "bar" syntax' do
        node['foo'] = 'bar'
        expect(node['foo']).to eq('bar')
        expect(node.size).to eq(2)
      end
    end
  end
end
