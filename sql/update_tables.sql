create or replace package update_tables is
    procedure update_user(
        first_name          "User".user_first_name % type,
        last_name           "User".user_last_name % type,
        email               "User".user_email % type,
        login               "User".user_login % type
    );
    
    procedure update_advertisement(
        name_of_product         Advertisement.product_name % type,
        price                   Advertisement.product_price % type,
        quantity                Advertisement.product_quantity % type,
        advert_id               Advertisement.advertisement_id % type,
        login                   Advertisement.user_login % type
    );
end update_tables;

create or replace package body update_tables is
    procedure update_user(
        first_name          "User".user_first_name % type,
        last_name           "User".user_last_name % type,
        email               "User".user_email % type,
        login               "User".user_login % type
    ) is
    begin
        update "User"
        set
            user_first_name = first_name,
            user_last_name = last_name,
            user_email = email
        where login = user_login;
        
        commit;
    end update_user;
    
    procedure update_advertisement(
        name_of_product         Advertisement.product_name % type,
        price                   Advertisement.product_price % type,
        quantity                Advertisement.product_quantity % type,
        advert_id               Advertisement.advertisement_id % type,
        login                   Advertisement.user_login % type
    ) is
        counter number;
    begin
        select
            count(*)
        into
            counter
        from
            Advertisement
        where
            name_of_product = product_name and login = user_login;
        
        if(counter = 0) then
            update Advertisement
            set
                product_name = name_of_product,
                product_price = price,
                product_quantity = quantity
            where advertisement_id = advert_id;
        end if;
        commit;
    end update_advertisement;
end update_tables;