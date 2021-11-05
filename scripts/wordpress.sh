echo Installing woocommerce
wp core download
wp core install --title="${WP_SITE_TITLE}" --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} \
  --admin_email=${WP_EMAIL} --skip-email --url=${SITEHOST}

echo Installing plugin and themes

wp plugin install woocommerce --activate
wp theme install storefront
wp theme activate storefront
wp plugin activate ${PLUGIN_NAME}


echo Installing $PLUGIN_NAME options
echo "The script you are running has basename `basename "$0"`, dirname `dirname "$0"`"

wp option update "woocommerce_store_address" "Edvard Griegs vei 3B" --autoload=yes
wp option update "woocommerce_store_city" "Bergen" --autoload=yes
wp option update "woocommerce_default_country" "NO" --autoload=yes
wp option update "woocommerce_store_postcode" "5059" --autoload=yes
wp option update "woocommerce_store_phone_number" "55555555" --autoload=yes
wp option update "porterbuddy_dev_public_token" "${PORTERBUDDY_DEV_PUBLIC_TOKEN}" --autoload=yes
wp option update "porterbuddy_dev_api_key" "${PORTERBUDDY_DEV_API_KEY}" --autoload=yes
wp option update "porterbuddy_testmode" "yes" --autoload=yes
wp option update "porterbuddy_checkout_template" "small_checkout" --autoload=yes
wp option update "porterbuddy_weight_grams" "2000" --autoload=yes
wp option update "porterbuddy_width_cm" "1" --autoload=yes
wp option update "porterbuddy_height_cm" "1" --autoload=yes
wp option update "porterbuddy_depth_cm" "1" --autoload=yes
wp option update "porterbuddy_pickup" --autoload=yes --format=json < $(dirname "$0")/opening_hours.json

wp wc shipping_zone create --name=Norway --user=admin
wp wc shipping_zone_method create 1 --method_id=porter_buddy --user=admin

echo Creating products
wp wc product create --name="Product 1" --type=simple --sku="PRODUCT-1" --regular_price=200 --user=admin
wp wc product create --name="Product 2" --type=simple --sku="PRODUCT-2" --regular_price=300 --user=admin