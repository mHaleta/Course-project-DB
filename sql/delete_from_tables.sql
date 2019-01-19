create or replace package delete_from_tables is
    procedure delete_from_user(
        login               "User".user_login % type
    );
    
    procedure delete_from_advertisement(
        ad_id               Advertisement.advertisement_id % type
    );
    
    function get_advert_by_id(
        ad_id               Advertisement.advertisement_id % type,
        login               Advertisement.user_login % type
    ) return varchar2;
end delete_from_tables;

create or replace package body delete_from_tables is
    procedure delete_from_user(
        login               "User".user_login % type
    ) is
    begin
        delete from "User"
        where login = "User".user_login;
        commit;
    end delete_from_user;
    
    procedure delete_from_advertisement(
        ad_id               Advertisement.advertisement_id % type
    ) is
    begin
        delete from Advertisement
        where ad_id = Advertisement.advertisement_id;
        commit;
    end delete_from_advertisement;
    
    function get_advert_by_id(
        ad_id               Advertisement.advertisement_id % type,
        login               Advertisement.user_login % type
    ) return varchar2 is
        counter number;
    begin
        select
            count(*)
        into
            counter
        from
            Advertisement
        where
            ad_id = advertisement_id and login = user_login;
            
        if (counter = 0) then
            return 'false';
        else
            return 'true';
        end if;
    end get_advert_by_id;
end delete_from_tables;