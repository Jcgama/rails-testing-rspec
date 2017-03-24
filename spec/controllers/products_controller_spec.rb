require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
    
    describe "GET #index" do
        it "populates an array of products" do 
            product = FactoryGirl.create(:product)
            get :index
            expect(assigns(:products)).to include(product)
        end
        it "renders the :index template" do
            get :index
            expect(response).to render_template :index 
        end
    end
    
    describe "GET #new" do
       it "renders the :new template" do
          get :new
          expect(response).to render_template :new
       end
    end
    
    describe "GET #show" do
       it "assigns the requested product to @product" do
          product = FactoryGirl.create(:product)
          get :show, id: product
          expect(assigns(:product)).to eq(product)
       end
       it "renders the #show view" do
          get :show, id: FactoryGirl.create(:product) 
          expect(response).to render_template :show
       end
    end
    
    describe "GET #edit" do
       it "assigns the requested product to @product" do
          product = FactoryGirl.create(:product)
          get :edit, id: product
          expect(assigns(:product)).to eq(product)
       end
       it "renders the #edit template" do
          get :edit, id: FactoryGirl.create(:product)
          expect(response).to render_template :edit
       end
    end
    
    describe "POST #create" do
        context "with valid attributes" do
            it "creates a new product" do
               expect{
                   post :create, product: FactoryGirl.attributes_for(:product)
               }.to change(Product, :count).by(1)
            end
            it "redirects to the new product" do
                post :create, product: FactoryGirl.attributes_for(:product)
                expect(response).to redirect_to(product_path(assigns(:product)))
            end
        end
        
        context "with invalid attributes" do
           it "should not save the new product" do
              expect{
                  post :create, product: FactoryGirl.attributes_for(:invalid_product)
              }.to_not change(Product, :count) 
           end
           it "should re-render the :new template" do
               post :create, product: FactoryGirl.attributes_for(:invalid_product)
               expect(response).to render_template :new
           end
        end
    end
    
    describe "PUT #update" do
       before :each do
        @product = FactoryGirl.create(:product, title: "Hello", description: "World")
       end
       
       context "with valid attributes" do
          it "locates the requested @product" do
              put :update, id: @product, product: FactoryGirl.attributes_for(:product)
              expect(assigns(:product)).to eq(@product)
          end
          it "changes the product's attributes" do
             put :update, id: @product, product: FactoryGirl.attributes_for(:product)
             @product.reload
             expect(@product.title).to eq("Asdf")
             expect(@product.description).to_not eq("Darkness")
          end
          
          it "redirects to updated product page" do
             put :update, id: @product, product: FactoryGirl.attributes_for(:product)
             expect(response).to redirect_to product_path(@product)
          end
       end
       
       context "with invalid attributes" do
          it "locates the requested @product" do
             put :update, id: @product, product: FactoryGirl.attributes_for(:invalid_product)
             expect(assigns(:product)).to eq(@product)
          end
          it "does not change the attributes" do
              put :update, id: @product, product: FactoryGirl.attributes_for(:invalid_product)
              @product.reload
              expect(@product.title).to_not eq(nil)
              expect(@product.title).to eq("Hello")
              expect(@product.description).to eq("World")
          end
          it "re-renders the edit template" do
             put :update, id: @product, product: FactoryGirl.attributes_for(:invalid_product)
             expect(response).to render_template :edit
          end
       end
    end
    
    
end