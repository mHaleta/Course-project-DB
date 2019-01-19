create or replace package show is
    type row_advertisement is record(
        ad_id           Advertisement.advertisement_id % type,
        ad_date         Advertisement."date" % type,
        vendor          Advertisement.user_login % type,
        prod_name       Advertisement.product_name % type,
        prod_price      Advertisement.product_price % type,
        prod_quantity   Advertisement.product_quantity % type
    );
    
    type row_user is record(
        first_name     "User".user_first_name % type,
        surname        "User".user_last_name % type,
        email          "User".user_email % type
    );
    
    type row_user_for_all is record(
        role_def        "User".role_definition % type,
        login           "User".user_login % type,
        first_name     "User".user_first_name % type,
        surname        "User".user_last_name % type,
        email          "User".user_email % type
    );
    
    type tbl_user_for_all is
        table of row_user_for_all;
    
    type tbl_user is
        table of row_user;
    
    type tbl_advertisement is
        table of row_advertisement;
        
    function show_advertisements return tbl_advertisement pipelined;
    
    function show_all_users return tbl_user_for_all pipelined;
    
    function show_user(
        login       "User".user_login % type
    ) return tbl_user pipelined;
    
    function find_adverts_by_product(
        prod         Advertisement.product_name % type
    ) return tbl_advertisement pipelined;
    
    function find_adverts_by_vendor(
        vend         Advertisement.user_login % type
    ) return tbl_advertisement pipelined;
end show;

create or replace package body show is
    function show_advertisements return tbl_advertisement pipelined is
        cursor advert_cursor is
            select 
                advertisement_id,
                "date",
                user_login,
                product_name,
                product_price,
                product_quantity
            from
                Advertisement;
                
    begin
        for cur in advert_cursor loop
            pipe row(cur);
        end loop;
        return;
    end show_advertisements;
    
    function find_adverts_by_product(
        prod           Advertisement.product_name % type
    ) return tbl_advertisement pipelined is
        cursor advert_cursor is
            select 
                advertisement_id,
                "date",
                user_login,
                product_name,
                product_price,
                product_quantity
            from
                Advertisement
            where
                product_name = prod;
    begin
        for cur in advert_cursor loop
            pipe row(cur);
        end loop;
        return;
    end find_adverts_by_product;
    
    function find_adverts_by_vendor(
        vend        Advertisement.user_login % type
    ) return tbl_advertisement pipelined is
        cursor advert_cursor is
            select 
                advertisement_id,
                "date",
                user_login,
                product_name,
                product_price,
                product_quantity
            from
                Advertisement
            where
                user_login = vend;
    begin
        for cur in advert_cursor loop
            pipe row(cur);
        end loop;
        return;
    end find_adverts_by_vendor;
    
    function show_user(
        login       "User".user_login % type
    ) return tbl_user pipelined is
        cursor user_cursor is
            select
                user_first_name,
                user_last_name,
                user_email
            from
                "User"
            where
                user_login = login;
    begin
        for cur in user_cursor loop
            pipe row(cur);
        end loop;
        return;
    end show_user;
    
    function show_all_users return tbl_user_for_all pipelined is
        cursor user_cursor is
            select
                role_definition,
                user_login,
                user_first_name,
                user_last_name,
                user_email
            from
                "User"
            where
                user_login != 'admin_login';
                
    begin
        for cur in user_cursor loop
            pipe row(cur);
        end loop;
        return;
    end show_all_users;
end show;