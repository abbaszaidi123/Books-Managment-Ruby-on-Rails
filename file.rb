rails new book_manager
cd book_manager

rails generate model Book title:string author:string description:text

rails generate controller Books

Rails.application.routes.draw do
  resources :books
  root "books#index"  # Set the root path to the index action of books
end

class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description)
  end
end

<h1>Books</h1>
<%= link_to 'New Book', new_book_path %>
<ul>
  <% @books.each do |book| %>
    <li>
      <%= link_to book.title, book %>
      <%= link_to 'Edit', edit_book_path(book) %>
      <%= link_to 'Destroy', book, method: :delete, data: { confirm: 'Are you sure?' } %>
    </li>
  <% end %>
</ul>

<h1><%= @book.title %></h1>
<p><strong>Author:</strong> <%= @book.author %></p>
<p><strong>Description:</strong> <%= @book.description %></p>
<%= link_to 'Edit', edit_book_path(@book) %> |
<%= link_to 'Back', books_path %>

<h1><%= action_name.capitalize %> Book</h1>

<%= form_with(model: @book, local: true) do |form| %>
  <% if @book.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@book.errors.count, "error") %> prohibited this book from being saved:</h2>
      <ul>
        <% @book.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= form.label :title %>
    <%= form.text_field :title %>
  </div>

  <div class="field">
    <%= form.label :author %>
    <%= form.text_field :author %>
  </div>

  <div class="field">
    <%= form.label :description %>
    <%= form.text_area :description %>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>

<%= link_to 'Back', books_path ```erb
%>

