require "test_helper"

# describe BooksController do
#   it "should get index" do #defaul test created by rails ...not even correct
#     get books_index_url #long version of books_path(relative link)
#     value(response).must_be :success?
#   end

  describe BooksController do
    it "should get index" do
      get books_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "should get a book's show page" do
      #Arrange
      id = book(:poodr).id

      #Act
      get book_path(id)

      #Assert
      must_respond_with :success
    end

    it "should respond with not_found if given an invalid id" do
      #Arrange with invalid id
      id = -1

      #Act
      get book_path(id)

      #Assert
      must_respond_with :not_found
      expect(flash[:danger]).must_equal "Cannot find the book -1" #debate in rails community if flash should be tested
    end
  end

  describe "edit" do
    it "should get the edit page for a valid book" do
      #Arrange
      # id = Book.find_by(id: params[:id].to_i)
      id = (:poodr).id

      #Act
      get edit_book_path(id)

      #Assert
      must_respond_with :success
    end


  describe "new" do
    it "should get a new form with the new_author_book_path" do
      #Arrange
      id = author(:jordan).id
      #Act
      get new_author_book_path(id)

      #Assert
      must_respond_with :success
    end
  end

  describe "destory" do
    it "can destroy a book given a valid id" do
      #Arrange
      id = books(:poodr).id

      #Act - Assert
      expect {
        delete book_path(id)
      }.must_change 'Book.count', -1 #can also do Book.length

      must_respond_with :redirect
      expect(flash[:success]).must_equal "#{title} delete"
      expect(Book.find_by(id: id)).must_equal nil
    end

    it "should respond with not_found for an invalid id" do
      #Arrange
      id =  -1

      #Act - Assert
      expect {
        delete book_path(id)
      }.must_change 'Book.count', 0

      must_respond_with :not_found
      expect(flash.now[:danger]).must_equal "Can't find #{id}"
    end
  end

  describe "update" do
    it "can update a model with valid params" do
      #let giant hash

      #Arrange
      id = books(:poodr).id

      #Act
      expect {
        patch book_path(id), params: book_hash
      }.wont_change 'Book.count'

      must_respond_with :redirect
      new_book = Book.find_by(id: id)

      expect(new_book.title).must_equal book_hash[:book][:title]
      expect(new_book.author_id).must_equal book_hash[:book][:author_id]
      expect(new_book.description).must_equal book_hash[:book][:description]
    end

    it "gives an error if the book params are invalid" do
      #Arrange
      book_hash[:book][:title] = nil
      id = books(:poodr).id
      old_poodr = books(:poodr)

      #Act
      expect {
        patch book_path(id), params: book_hash
      }.wont_change 'Book.count'
      new_poodr = Book.find(id)

      must_respond_with :bad_request
      expect(old_poodr.title).must_equal book_hash[:book][:title]
      expect(old_poodr.author_id).must_equal book_hash[:book][:author_id]
      expect(old_poodr.description).must_equal book_hash[:book][:description]
    end


    end

    it "gives not_found for a book that doesn't exist" do



    end
  end



end
