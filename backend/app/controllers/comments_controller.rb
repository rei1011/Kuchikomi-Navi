# frozen_string_literal: true

require 'rubygems'
require 'mechanize'
require 'nokogiri'

class CommentsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_comment, only: %i[show update destroy]

  # GET /comments
  def index
    agent = Mechanize.new
    page = agent.get('https://fujoho.jp/index.php?p=shop_list&w=M%E6%80%A7%E6%84%9F')
    doc = Nokogiri::HTML.parse(page.body)

    doc.css('.shop_header_info_shopname').each do |shop|
      p shop.children.text
    end

    @comments = Comment.all

    render(json: @comments)
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(
      :store_name,
      :prostitute_name,
      :comment,
      :publication_date
    )
  end
end
