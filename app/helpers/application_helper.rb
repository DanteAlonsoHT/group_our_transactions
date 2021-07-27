module ApplicationHelper
    def total_amount_internal(user)
        @total_amount = 0
        @all_bitcoin = Investment.all.where("user_id = ? and crypto = ? and group_id != 5", user.id,"Bitcoin")
        unless @all_bitcoin.nil?
            @all_bitcoin.each do |bitcoin|
                @total_amount = @total_amount + bitcoin.amount*35000
            end
        end

        @all_ethereum = Investment.all.where("user_id = ? and crypto = ? and group_id != 5", user.id,"Ethereum")
        unless @all_ethereum.nil?
            @all_ethereum.each do |ethereum|
                @total_amount = @total_amount + ethereum.amount*2027
            end
        end

        @all_xrp = Investment.all.where("user_id = ? and crypto = ? and group_id != 5", user.id,"XRP")
        unless @all_xrp.nil?
            @all_xrp.each do |xrp|
                @total_amount = @total_amount + xrp.amount*0.64
            end
        end

        @all_dogecoin = Investment.all.where("user_id = ? and crypto = ? and group_id != 5", user.id,"Dogecoin")
        unless @all_dogecoin.nil?
            @all_dogecoin.each do |dogecoin|
                @total_amount = @total_amount + dogecoin.amount*0.61
            end
        end

        @all_usd = Investment.all.where("user_id = ? and crypto = ? and group_id != 5", user.id,"USD (no crypto)")
        unless @all_usd.nil?
            @all_usd.each do |usd|
                @total_amount = @total_amount + usd.amount
            end
        end
        (@total_amount).round(2)
    end

    def total_amount_external(user)
        @total_amount = 0
        @all_bitcoin = Investment.all.where("user_id = ? and crypto = ? and group_id = 5", user.id,"Bitcoin")
        unless @all_bitcoin.nil?
            @all_bitcoin.each do |bitcoin|
                @total_amount = @total_amount + bitcoin.amount*35000
            end
        end

        @all_ethereum = Investment.all.where("user_id = ? and crypto = ? and group_id = 5", user.id,"Ethereum")
        unless @all_ethereum.nil?
            @all_ethereum.each do |ethereum|
                @total_amount = @total_amount + ethereum.amount*2027
            end
        end

        @all_xrp = Investment.all.where("user_id = ? and crypto = ? and group_id = 5", user.id,"XRP")
        unless @all_xrp.nil?
            @all_xrp.each do |xrp|
                @total_amount = @total_amount + xrp.amount*0.64
            end
        end

        @all_dogecoin = Investment.all.where("user_id = ? and crypto = ? and group_id = 5", user.id,"Dogecoin")
        unless @all_dogecoin.nil?
            @all_dogecoin.each do |dogecoin|
                @total_amount = @total_amount + dogecoin.amount*0.61
            end
        end

        @all_usd = Investment.all.where("user_id = ? and crypto = ? and group_id = 5", user.id,"USD (no crypto)")
        unless @all_usd.nil?
            @all_usd.each do |usd|
                @total_amount = @total_amount + usd.amount
            end
        end
        (@total_amount).round(2)
    end

    def total_amount_all
        @total_amount = 0
        @all_bitcoin = Investment.all.where("crypto = ?","Bitcoin")
        unless @all_bitcoin.nil?
            @all_bitcoin.each do |bitcoin|
                @total_amount = @total_amount + bitcoin.amount*35000
            end
        end

        @all_ethereum = Investment.all.where("crypto = ?","Ethereum")
        unless @all_ethereum.nil?
            @all_ethereum.each do |ethereum|
                @total_amount = @total_amount + ethereum.amount*2027
            end
        end

        @all_xrp = Investment.all.where("crypto = ?","XRP")
        unless @all_xrp.nil?
            @all_xrp.each do |xrp|
                @total_amount = @total_amount + xrp.amount*0.64
            end
        end

        @all_dogecoin = Investment.all.where("crypto = ?","Dogecoin")
        unless @all_dogecoin.nil?
            @all_dogecoin.each do |dogecoin|
                @total_amount = @total_amount + dogecoin.amount*0.61
            end
        end

        @all_usd = Investment.all.where("crypto = ?","USD (no crypto)")
        unless @all_usd.nil?
            @all_usd.each do |usd|
                @total_amount = @total_amount + usd.amount
            end
        end
        (@total_amount).round(2)
    end
end
