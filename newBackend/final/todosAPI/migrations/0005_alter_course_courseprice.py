# Generated by Django 4.2.7 on 2023-12-31 17:21

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("todosAPI", "0004_alter_user_phonenumber"),
    ]

    operations = [
        migrations.AlterField(
            model_name="course",
            name="coursePrice",
            field=models.IntegerField(),
        ),
    ]