
from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

from myntra_app.views import *

urlpatterns = [
    path('admin/', admin.site.urls),
    path('register/',register),
    path('login/',login),
    path('get_product_categories/', get_product_categories),
    path('get_product_subcategories/<int:cat_id>', get_product_subcategories),
    path('get_products/<int:subcat_id>', get_products),
    path('add_to_cart/<int:product_id>', add_to_cart),
    path('get_cart/', add_to_cart),
    path('profile/', get_profile),
    path('delete/', delete_cart),
     path('delete_wishlist/', delete_wishlist),
     path('add_wishlist/<int:product_id>', add_to_wishlist),
    path('get_wishlist/', add_to_wishlist),
    
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
