import email
from django.db import models

class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=100)
    email = models.CharField(max_length=100)
    phone = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
    token = models.CharField(max_length=100)
    def to_db(self, my_json):
        self.name=my_json["name"]
        self.email=my_json["email"]
        self.phone=my_json["phone"]
        self.password=my_json["password"]
        self.token = my_json["token"]

class Product_Category(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=100)
    image_path = models.CharField(max_length=255)


class Product_Subcategory(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=100)
    image_path = models.CharField(max_length=255)
    product_category = models.ForeignKey(
        Product_Category, on_delete=models.CASCADE, blank=False, null=True
    )


class Product(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=100)
    image_path = models.CharField(max_length=255)
    product_price=models.CharField(max_length=100)
    product_desc=models.CharField(max_length=100)
    product_size=models.CharField(max_length=100)
    product_subcategory = models.ForeignKey(
        Product_Subcategory, on_delete=models.CASCADE, blank=False, null=True
    )
  
  
class Wishlist(models.Model):
    id = models.BigAutoField(primary_key=True)
    product = models.ForeignKey(
        Product, on_delete=models.CASCADE, blank=False, null=True
    )
    user = models.ForeignKey(User, on_delete=models.CASCADE,  blank=False, null=True)
    def to_db(self, my_json):
        self.product = my_json["product"]
        self.user = my_json['user']  


class Cart(models.Model):
    id = models.BigAutoField(primary_key=True)
    product = models.ForeignKey(
        Product, on_delete=models.CASCADE, blank=False, null=True
    )
    user = models.ForeignKey(User, on_delete=models.CASCADE,  blank=False, null=True)
    def to_db(self, my_json):
        self.product = my_json["product"]
        self.user = my_json['user']
       
    