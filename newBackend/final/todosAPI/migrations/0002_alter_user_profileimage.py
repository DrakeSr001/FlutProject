# Generated by Django 4.2.7 on 2023-12-29 21:20

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("todosAPI", "0001_initial"),
    ]

    operations = [
        migrations.AlterField(
            model_name="user",
            name="profileImage",
            field=models.CharField(
                default="https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg",
                max_length=250,
                null=True,
            ),
        ),
    ]