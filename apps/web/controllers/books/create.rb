module Web::Controllers::Books
  class Create
    include Web::Action

    def call(params)
      book = Book.new(params[:book])
      BookRepository.create book

      redirect_to '/books'
    end
  end
end
