from tabnanny import check
import token
from django.shortcuts import render
import json
from .models import *
import random
from django.http import JsonResponse
from django.core import serializers as core_serializers

def register(request):
    if request.method=='POST':
        try:
            x = request.body
            my_json = json.loads(x)
            email = my_json["email"]
            name = my_json["name"]
            phone = my_json["phone"]
            password = my_json["password"]
            user = User.objects.filter(email=email).first()
            # print(user.name)
            token = random.randint(100000, 999999)
            if user is None:
                user = User()
                user.to_db({"email": email, 'name':name, 'phone':phone, 'password':password, 'token':token})
                user.save()
            return JsonResponse(
                {"message": "success"}
            )
        except Exception as e:
            return JsonResponse({"message": f"err {e}"})
    else:
        return JsonResponse({"message": "only Post"})

def login(request):
    if request.method == "POST":
        x = json.loads(request.body)
        email, password = x["email"], x["password"]
        check_login = User.objects.filter(email=email, password=password).first()
        if (check_login is not None):
            token=check_login.token
            return JsonResponse(
                {"message": "success", "token": token}
            )
        elif( User.objects.filter(email=email ).first()):
            return JsonResponse(
                {"message": "Invalid Password"}
            )
        else:
            return JsonResponse({"message": "User not found"})
    else:
       return JsonResponse({"message": "Must be GET request"})

def get_profile(request):
    if request.method == "GET":
        x=request.headers
        token = x["token"]
        user_obj = User.objects.filter(token=token).first()
        print("token matched")
        if (user_obj is not None) :

            # data_response = JsonResponse(
            #     core_serializers.serialize("json", user_obj), safe=False
            # )
            return JsonResponse([user_obj.name, user_obj.email, user_obj.phone], safe=False)
        else:
            return JsonResponse({"message": "Invalid token"})
    else:
        return JsonResponse({"message": "only GET"})


def get_product_categories(request):
    if request.method == "GET":
        x = request.headers
        token = x["token"]
        check_token = User.objects.filter(token=token).first()
        print("token matched")
        if (check_token is not None) :
            product_category = Product_Category.objects.all()

            data_response = JsonResponse(
                core_serializers.serialize("json", product_category), safe=False
            )
            return data_response
        else:
            return JsonResponse({"message": "Invalid token"})
    else:
        return JsonResponse({"message": "only GET"})


def get_product_subcategories(request, cat_id):
    if request.method == 'GET':
        x = request.headers
        token = x['token']
        check_token = User.objects.filter(token=token).first()
        print("token matched")
        if (check_token is not None):
            product_category = Product_Category.objects.filter(id=cat_id).first()
            product_subcategory = Product_Subcategory.objects.filter(product_category=product_category).all()

            data_response = JsonResponse(
                core_serializers.serialize("json", product_subcategory), safe=False
            )
            return data_response
        else:
            return JsonResponse({"message": "Invalid token"})
    else:
        return JsonResponse({"message": "only GET"})
    

def get_products(request, subcat_id):
    if request.method == "GET":
        x = request.headers
        token = x["token"]
        check_token = User.objects.filter(token=token).first()
        if (check_token is not None):
            prod_sub_cat = Product_Subcategory.objects.filter(id=subcat_id).first()
            products = Product.objects.filter(product_subcategory=prod_sub_cat).all()

            data_response = JsonResponse(
                core_serializers.serialize("json", products), safe=False
            )
            return data_response
        else:
            return JsonResponse({"message": "Invalid tooken"})
    else:
        return JsonResponse({"only GET"})


def add_to_cart(request, product_id=1):
    if request.method == "POST":
        x = request.headers
        token = x["token"]
        user_obj = User.objects.filter(token=token).first()
        if (user_obj is not None):
            cart_items=Cart.objects.filter(product=product_id).first()
            if(cart_items is None):
                if(Product.objects.filter(id=product_id).exists()):
                     products = Product.objects.filter(id=product_id).first()
                     cart = Cart()
                     cart.to_db({ "product": products, 'user': user_obj})
                     cart.save()
               
                return JsonResponse({"message": "Added to cart"})
            else:
                  return JsonResponse({"message": "Product already exists in cart"})
        else:
            return JsonResponse({"message": "Invalid token"})

    elif request.method == "GET":
        x = request.headers
        token = x["token"]
        user_obj = User.objects.filter(token=token).first()
        if (user_obj is not None):
            user_cart = Cart.objects.filter(user=user_obj).all()

            wishlist_items = []
            for item in user_cart:
                product = Product.objects.filter(id=item.product.id).first()
                wishlist_items.append(product)

            data_response = JsonResponse(
                core_serializers.serialize("json", wishlist_items), safe=False
            )
            return data_response
        else:
            return JsonResponse({"message": "Invalid token"})

def delete_cart(request):
    if request.method=='POST':
        x = request.headers
        token = x["token"]
        user_obj = User.objects.filter(token=token).first()
        body=json.loads(request.body)
        cartproduct = Product.objects.filter(id=body['id']).first()
        cartitem=Cart.objects.filter(product=cartproduct, user=user_obj).first()
        cartitem.delete()
        return JsonResponse({"message":"Item deleted"})
    else:
        return JsonResponse({"message":"Item is not deleted"})

def delete_wishlist(request):
    if request.method=='POST':
        x = request.headers
        token = x["token"]
        user_obj = User.objects.filter(token=token).first()
        body=json.loads(request.body)
        wishlistproduct = Product.objects.filter(id=body['id']).first()
        wishlistitem=Wishlist.objects.filter(product=wishlistproduct, user=user_obj).first()
        wishlistitem.delete()
        return JsonResponse({"message":"Item deleted"})
    else:
        return JsonResponse({"message":"Item is not deleted"})


def add_to_wishlist(request, product_id=1):
    if request.method == "POST":
        x = request.headers
        token = x["token"]
        user_obj = User.objects.filter(token=token).first()
        if (user_obj is not None):
            wishlist_items=Wishlist.objects.filter(product=product_id).first()
            if(wishlist_items is None):
                if(Product.objects.filter(id=product_id).exists()):
                     products = Product.objects.filter(id=product_id).first()
                     wishlist = Wishlist()
                     wishlist.to_db({ "product": products, 'user': user_obj})
                     wishlist.save()
               
                return JsonResponse({"message": "Added to Wishlist"})
            else:
                  return JsonResponse({"message": "Product already exists in Wishlist"})
        else:
            return JsonResponse({"message": "Invalid token"})

    elif request.method == "GET":
        x = request.headers
        token = x["token"]
        user_obj = User.objects.filter(token=token).first()
        if (user_obj is not None):
            user_wishlist= Wishlist.objects.filter(user=user_obj).all()

            wishlist_items = []
            for item in user_wishlist:
                product = Product.objects.filter(id=item.product.id).first()
                wishlist_items.append(product)

            data_response = JsonResponse(
                core_serializers.serialize("json", wishlist_items), safe=False
            )
            return data_response
        else:
            return JsonResponse({"message": "Invalid token"})


    










