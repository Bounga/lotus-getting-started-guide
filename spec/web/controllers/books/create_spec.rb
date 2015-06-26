require 'spec_helper'
require_relative '../../../../apps/web/controllers/books/create'

describe Web::Controllers::Books::Create do
  let(:action) { Web::Controllers::Books::Create.new }

  before do
    BookRepository.clear
  end

  describe 'with valid params' do
    let(:params) { Hash[book: { title: '1984', author: 'George Orwell' }] }

    it 'creates a new book' do
      action.call(params)
      BookRepository.all.wont_be_empty
    end

    it 'redirects the user to the books listing' do
      response = action.call(params)

      response[0].must_equal 302
      response[1]['Location'].must_equal '/books'
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[book: {}] }

    it 're-renders the books#new view' do
      response = action.call(params)
      response[0].must_equal 200
    end

    it 'sets errors in object' do
      action.call(params)

      refute action.params.valid?

      action.errors.for('book.title').wont_be_empty
      action.errors.for('book.author').wont_be_empty
    end
  end
end
