# Generated by Django 4.2.5 on 2023-09-23 08:16

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('myntra_app', '0005_remove_product_product_subcategory_productslist_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='product',
            name='products_list',
        ),
        migrations.AddField(
            model_name='product',
            name='product_subcategory',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='myntra_app.product_subcategory'),
        ),
        migrations.DeleteModel(
            name='ProductsList',
        ),
    ]
