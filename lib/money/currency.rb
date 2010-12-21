# encoding: utf-8

class Money

  # Represents a specific currency unit.
  class Currency
    include Comparable

    # Thrown when an unknown currency is requested.
    class UnknownCurrency < StandardError;
    end

    # List of known currencies.
    #
    # == monetary unit
    # The standard unit of value of a currency, as the dollar in the United States or the peso in Mexico.
    # http://www.answers.com/topic/monetary-unit
    # == fractional monetary unit, subunit
    # A monetary unit that is valued at a fraction (usually one hundredth) of the basic monetary unit
    # http://www.answers.com/topic/fractional-monetary-unit-subunit
    #
    # See http://en.wikipedia.org/wiki/List_of_circulating_currencies
    TABLE = {
        :aed => {:priority => 100, :iso_code => "AED", :symbol_first => true, :html_entity => "", :name => "United Arab Emirates Dirham", :symbol => "د.إ", :subunit => "Fils", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :afn => {:priority => 100, :iso_code => "AFN", :symbol_first => false, :html_entity => "", :name => "Afghan Afghani", :symbol => "؋", :subunit => "Pul", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :all => {:priority => 100, :iso_code => "ALL", :symbol_first => false, :html_entity => "", :name => "Albanian Lek", :symbol => "L", :subunit => "Qintar", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :amd => {:priority => 100, :iso_code => "AMD", :symbol_first => false, :html_entity => "", :name => "Armenian Dram", :symbol => "դր.", :subunit => "Luma", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :ang => {:priority => 100, :iso_code => "ANG", :symbol_first => true, :html_entity => "&#x0192;", :name => "Netherlands Antillean Gulden", :symbol => "ƒ", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :aoa => {:priority => 100, :iso_code => "AOA", :symbol_first => false, :html_entity => "", :name => "Angolan Kwanza", :symbol => "Kz", :subunit => "Cêntimo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :ars => {:priority => 100, :iso_code => "ARS", :symbol_first => true, :html_entity => "&#x20B1;", :name => "Argentine Peso", :symbol => "$", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :aud => {:priority => 4,   :iso_code => "AUD", :symbol_first => true, :html_entity => "$", :name => "Australian Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :awg => {:priority => 100, :iso_code => "AWG", :symbol_first => false, :html_entity => "&#x0192;", :name => "Aruban Florin", :symbol => "ƒ", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :azn => {:priority => 100, :iso_code => "AZN", :symbol_first => true, :html_entity => "", :name => "Azerbaijani Manat", :symbol => nil, :subunit => "Qəpik", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :bam => {:priority => 100, :iso_code => "BAM", :symbol_first => true, :html_entity => "", :name => "Bosnia and Herzegovina Convertible Mark", :symbol => "KM or КМ", :subunit => "Fening", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :bbd => {:priority => 100, :iso_code => "BBD", :symbol_first => false, :html_entity => "$", :name => "Barbadian Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :bdt => {:priority => 100, :iso_code => "BDT", :symbol_first => true, :html_entity => "", :name => "Bangladeshi Taka", :symbol => "৳", :subunit => "Paisa", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :bgn => {:priority => 100, :iso_code => "BGN", :symbol_first => true, :html_entity => "", :name => "Bulgarian Lev", :symbol => "лв", :subunit => "Stotinka", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :bhd => {:priority => 100, :iso_code => "BHD", :symbol_first => true, :html_entity => "", :name => "Bahraini Dinar", :symbol => "ب.د", :subunit => "Fils", :subunit_to_unit => 1000, :decimal_mark => ".", :delimiter => ","},
        :bif => {:priority => 100, :iso_code => "BIF", :symbol_first => false, :html_entity => "", :name => "Burundian Franc", :symbol => "Fr", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :bmd => {:priority => 100, :iso_code => "BMD", :symbol_first => true, :html_entity => "$", :name => "Bermudian Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :bnd => {:priority => 100, :iso_code => "BND", :symbol_first => true, :html_entity => "$", :name => "Brunei Dollar", :symbol => "$", :subunit => "Sen", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :bob => {:priority => 100, :iso_code => "BOB", :symbol_first => true, :html_entity => "", :name => "Bolivian Boliviano", :symbol => "Bs.", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :brl => {:priority => 100, :iso_code => "BRL", :symbol_first => true, :html_entity => "R\$", :name => "Brazilian Real", :symbol => "R$ ", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :bsd => {:priority => 100, :iso_code => "BSD", :symbol_first => true, :html_entity => "$", :name => "Bahamian Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :btn => {:priority => 100, :iso_code => "BTN", :symbol_first => false, :html_entity => "", :name => "Bhutanese Ngultrum", :symbol => nil, :subunit => "Chertrum", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :bwp => {:priority => 100, :iso_code => "BWP", :symbol_first => true, :html_entity => "", :name => "Botswana Pula", :symbol => "P", :subunit => "Thebe", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :byr => {:priority => 100, :iso_code => "BYR", :symbol_first => false, :html_entity => "", :name => "Belarusian Ruble", :symbol => "Br", :subunit => "Kapyeyka", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :bzd => {:priority => 100, :iso_code => "BZD", :symbol_first => true, :html_entity => "$", :name => "Belize Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :cad => {:priority => 5,   :iso_code => "CAD", :symbol_first => true, :html_entity => "$", :name => "Canadian Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :cdf => {:priority => 100, :iso_code => "CDF", :symbol_first => false, :html_entity => "", :name => "Congolese Franc", :symbol => "Fr", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :chf => {:priority => 100, :iso_code => "CHF", :symbol_first => true, :html_entity => "", :name => "Swiss Franc", :symbol => "Fr", :subunit => "Rappen", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :clp => {:priority => 100, :iso_code => "CLP", :symbol_first => true, :html_entity => "&#x20B1;", :name => "Chilean Peso", :symbol => "$", :subunit => "Peso", :subunit_to_unit => 1, :decimal_mark => ",", :delimiter => "."},
        :cny => {:priority => 100, :iso_code => "CNY", :symbol_first => true, :html_entity => "&#x5713;", :name => "Chinese Renminbi Yuan", :symbol => "¥", :subunit => "Jiao", :subunit_to_unit => 10, :decimal_mark => ".", :delimiter => ","},
        :cop => {:priority => 100, :iso_code => "COP", :symbol_first => true, :html_entity => "&#x20B1;", :name => "Colombian Peso", :symbol => "$", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :crc => {:priority => 100, :iso_code => "CRC", :symbol_first => true, :html_entity => "&#x20A1;", :name => "Costa Rican Colón", :symbol => "₡", :subunit => "Céntimo", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :cuc => {:priority => 100, :iso_code => "CUC", :symbol_first => false, :html_entity => "", :name => "Cuban Convertible Peso", :symbol => "$", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :cup => {:priority => 100, :iso_code => "CUP", :symbol_first => true, :html_entity => "&#x20B1;", :name => "Cuban Peso", :symbol => "$", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :cve => {:priority => 100, :iso_code => "CVE", :symbol_first => false, :html_entity => "", :name => "Cape Verdean Escudo", :symbol => "$ or Esc", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :czk => {:priority => 100, :iso_code => "CZK", :symbol_first => true, :html_entity => "", :name => "Czech Koruna", :symbol => "Kč", :subunit => "Haléř", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :djf => {:priority => 100, :iso_code => "DJF", :symbol_first => false, :html_entity => "", :name => "Djiboutian Franc", :symbol => "Fr", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :dkk => {:priority => 100, :iso_code => "DKK", :symbol_first => true, :html_entity => "", :name => "Danish Krone", :symbol => "kr", :subunit => "Øre", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :dop => {:priority => 100, :iso_code => "DOP", :symbol_first => true, :html_entity => "&#x20B1;", :name => "Dominican Peso", :symbol => "$", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :dzd => {:priority => 100, :iso_code => "DZD", :symbol_first => false, :html_entity => "", :name => "Algerian Dinar", :symbol => "د.ج", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :eek => {:priority => 100, :iso_code => "EEK", :symbol_first => false, :html_entity => "", :name => "Estonian Kroon", :symbol => "KR", :subunit => "Sent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :egp => {:priority => 100, :iso_code => "EGP", :symbol_first => true, :html_entity => "&#x00A3;", :name => "Egyptian Pound", :symbol => "£ or ج.م", :subunit => "Piastre", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :ern => {:priority => 100, :iso_code => "ERN", :symbol_first => false, :html_entity => "", :name => "Eritrean Nakfa", :symbol => "Nfk", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :etb => {:priority => 100, :iso_code => "ETB", :symbol_first => false, :html_entity => "", :name => "Ethiopian Birr", :symbol => nil, :subunit => "Santim", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :eur => {:priority => 2,   :iso_code => "EUR", :symbol_first => false, :html_entity => "&#x20AC;", :name => "Euro", :symbol => "€", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :fjd => {:priority => 100, :iso_code => "FJD", :symbol_first => false, :html_entity => "$", :name => "Fijian Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :fkp => {:priority => 100, :iso_code => "FKP", :symbol_first => false, :html_entity => "&#x00A3;", :name => "Falkland Pound", :symbol => "£", :subunit => "Penny", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :gbp => {:priority => 3,   :iso_code => "GBP", :symbol_first => true, :html_entity => "&#x00A3;", :name => "British Pound", :symbol => "£", :subunit => "Penny", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :gel => {:priority => 100, :iso_code => "GEL", :symbol_first => false, :html_entity => "", :name => "Georgian Lari", :symbol => "ლ", :subunit => "Tetri", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :ghs => {:priority => 100, :iso_code => "GHS", :symbol_first => true, :html_entity => "&#x20B5;", :name => "Ghanaian Cedi", :symbol => "₵", :subunit => "Pesewa", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :gip => {:priority => 100, :iso_code => "GIP", :symbol_first => true, :html_entity => "&#x00A3;", :name => "Gibraltar Pound", :symbol => "£", :subunit => "Penny", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :gmd => {:priority => 100, :iso_code => "GMD", :symbol_first => false, :html_entity => "", :name => "Gambian Dalasi", :symbol => "D", :subunit => "Butut", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :gnf => {:priority => 100, :iso_code => "GNF", :symbol_first => false, :html_entity => "", :name => "Guinean Franc", :symbol => "Fr", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :gtq => {:priority => 100, :iso_code => "GTQ", :symbol_first => true, :html_entity => "", :name => "Guatemalan Quetzal", :symbol => "Q", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :gyd => {:priority => 100, :iso_code => "GYD", :symbol_first => false, :html_entity => "$", :name => "Guyanese Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :hkd => {:priority => 100, :iso_code => "HKD", :symbol_first => true, :html_entity => "$", :name => "Hong Kong Dollar", :symbol => "$", :subunit => "Ho", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :hnl => {:priority => 100, :iso_code => "HNL", :symbol_first => true, :html_entity => "", :name => "Honduran Lempira", :symbol => "L", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :hrk => {:priority => 100, :iso_code => "HRK", :symbol_first => true, :html_entity => "", :name => "Croatian Kuna", :symbol => "kn", :subunit => "Lipa", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :htg => {:priority => 100, :iso_code => "HTG", :symbol_first => false, :html_entity => "", :name => "Haitian Gourde", :symbol => "G", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :huf => {:priority => 100, :iso_code => "HUF", :symbol_first => true, :html_entity => "", :name => "Hungarian Forint", :symbol => "Ft", :subunit => "Fillér", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :idr => {:priority => 100, :iso_code => "IDR", :symbol_first => true, :html_entity => "", :name => "Indonesian Rupiah", :symbol => "Rp", :subunit => "Sen", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :ils => {:priority => 100, :iso_code => "ILS", :symbol_first => true, :html_entity => "&#x20AA;", :name => "Israeli New Sheqel", :symbol => "₪", :subunit => "Agora", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :inr => {:priority => 100, :iso_code => "INR", :symbol_first => true, :html_entity => "&#x20A8;", :name => "Indian Rupee", :symbol => "₨", :subunit => "Paisa", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :iqd => {:priority => 100, :iso_code => "IQD", :symbol_first => false, :html_entity => "", :name => "Iraqi Dinar", :symbol => "ع.د", :subunit => "Fils", :subunit_to_unit => 1000, :decimal_mark => ".", :delimiter => ","},
        :irr => {:priority => 100, :iso_code => "IRR", :symbol_first => true, :html_entity => "&#xFDFC;", :name => "Iranian Rial", :symbol => "﷼", :subunit => "Dinar", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :isk => {:priority => 100, :iso_code => "ISK", :symbol_first => true, :html_entity => "", :name => "Icelandic Króna", :symbol => "kr", :subunit => "Eyrir", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :jmd => {:priority => 100, :iso_code => "JMD", :symbol_first => true, :html_entity => "$", :name => "Jamaican Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :jod => {:priority => 100, :iso_code => "JOD", :symbol_first => true, :html_entity => "", :name => "Jordanian Dinar", :symbol => "د.ا", :subunit => "Piastre", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :jpy => {:priority => 6,   :iso_code => "JPY", :symbol_first => true, :html_entity => "&#x00A5;", :name => "Japanese Yen", :symbol => "¥", :subunit => "Sen", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :kes => {:priority => 100, :iso_code => "KES", :symbol_first => true, :html_entity => "", :name => "Kenyan Shilling", :symbol => "Sh", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :kgs => {:priority => 100, :iso_code => "KGS", :symbol_first => false, :html_entity => "", :name => "Kyrgyzstani Som", :symbol => nil, :subunit => "Tyiyn", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :khr => {:priority => 100, :iso_code => "KHR", :symbol_first => false, :html_entity => "&#x17DB;", :name => "Cambodian Riel", :symbol => "៛", :subunit => "Sen", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :kmf => {:priority => 100, :iso_code => "KMF", :symbol_first => false, :html_entity => "", :name => "Comorian Franc", :symbol => "Fr", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :kpw => {:priority => 100, :iso_code => "KPW", :symbol_first => false, :html_entity => "&#x20A9;", :name => "North Korean Won", :symbol => "₩", :subunit => "Chŏn", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :krw => {:priority => 100, :iso_code => "KRW", :symbol_first => true, :html_entity => "&#x20A9;", :name => "South Korean Won", :symbol => "₩", :subunit => "Jeon", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :kwd => {:priority => 100, :iso_code => "KWD", :symbol_first => true, :html_entity => "", :name => "Kuwaiti Dinar", :symbol => "د.ك", :subunit => "Fils", :subunit_to_unit => 1000, :decimal_mark => ".", :delimiter => ","},
        :kyd => {:priority => 100, :iso_code => "KYD", :symbol_first => true, :html_entity => "$", :name => "Cayman Islands Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :kzt => {:priority => 100, :iso_code => "KZT", :symbol_first => false, :html_entity => "", :name => "Kazakhstani Tenge", :symbol => "〒", :subunit => "Tiyn", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :lak => {:priority => 100, :iso_code => "LAK", :symbol_first => false, :html_entity => "&#x20AD;", :name => "Lao Kip", :symbol => "₭", :subunit => "Att", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :lbp => {:priority => 100, :iso_code => "LBP", :symbol_first => true, :html_entity => "&#x00A3;", :name => "Lebanese Lira", :symbol => "ل.ل", :subunit => "Piastre", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :lkr => {:priority => 100, :iso_code => "LKR", :symbol_first => false, :html_entity => "&#x0BF9;", :name => "Sri Lankan Rupee", :symbol => "₨", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :lrd => {:priority => 100, :iso_code => "LRD", :symbol_first => false, :html_entity => "$", :name => "Liberian Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :lsl => {:priority => 100, :iso_code => "LSL", :symbol_first => false, :html_entity => "", :name => "Lesotho Loti", :symbol => "L", :subunit => "Sente", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :ltl => {:priority => 100, :iso_code => "LTL", :symbol_first => true, :html_entity => "", :name => "Lithuanian Litas", :symbol => "Lt", :subunit => "Centas", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :lvl => {:priority => 100, :iso_code => "LVL", :symbol_first => true, :html_entity => "", :name => "Latvian Lats", :symbol => "Ls", :subunit => "Santīms", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :lyd => {:priority => 100, :iso_code => "LYD", :symbol_first => false, :html_entity => "", :name => "Libyan Dinar", :symbol => "ل.د", :subunit => "Dirham", :subunit_to_unit => 1000, :decimal_mark => ".", :delimiter => ","},
        :mad => {:priority => 100, :iso_code => "MAD", :symbol_first => false, :html_entity => "", :name => "Moroccan Dirham", :symbol => "د.م.", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :mdl => {:priority => 100, :iso_code => "MDL", :symbol_first => false, :html_entity => "", :name => "Moldovan Leu", :symbol => "L", :subunit => "Ban", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :mga => {:priority => 100, :iso_code => "MGA", :symbol_first => false, :html_entity => "", :name => "Malagasy Ariary", :symbol => nil, :subunit => "Iraimbilanja", :subunit_to_unit => 5, :decimal_mark => ".", :delimiter => ","},
        :mkd => {:priority => 100, :iso_code => "MKD", :symbol_first => false, :html_entity => "", :name => "Macedonian Denar", :symbol => "ден", :subunit => "Deni", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :mmk => {:priority => 100, :iso_code => "MMK", :symbol_first => false, :html_entity => "", :name => "Myanmar Kyat", :symbol => "K", :subunit => "Pya", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :mnt => {:priority => 100, :iso_code => "MNT", :symbol_first => false, :html_entity => "&#x20AE;", :name => "Mongolian Tögrög", :symbol => "₮", :subunit => "Möngö", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :mop => {:priority => 100, :iso_code => "MOP", :symbol_first => false, :html_entity => "", :name => "Macanese Pataca", :symbol => "P", :subunit => "Avo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :mro => {:priority => 100, :iso_code => "MRO", :symbol_first => false, :html_entity => "", :name => "Mauritanian Ouguiya", :symbol => "UM", :subunit => "Khoums", :subunit_to_unit => 5, :decimal_mark => ".", :delimiter => ","},
        :mur => {:priority => 100, :iso_code => "MUR", :symbol_first => true, :html_entity => "&#x20A8;", :name => "Mauritian Rupee", :symbol => "₨", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :mvr => {:priority => 100, :iso_code => "MVR", :symbol_first => false, :html_entity => "", :name => "Maldivian Rufiyaa", :symbol => "ރ.", :subunit => "Laari", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :mwk => {:priority => 100, :iso_code => "MWK", :symbol_first => false, :html_entity => "", :name => "Malawian Kwacha", :symbol => "MK", :subunit => "Tambala", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :mxn => {:priority => 100, :iso_code => "MXN", :symbol_first => true, :html_entity => "$", :name => "Mexican Peso", :symbol => "$", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :myr => {:priority => 100, :iso_code => "MYR", :symbol_first => true, :html_entity => "", :name => "Malaysian Ringgit", :symbol => "RM", :subunit => "Sen", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :mzn => {:priority => 100, :iso_code => "MZN", :symbol_first => true, :html_entity => "", :name => "Mozambican Metical", :symbol => "MTn", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :nad => {:priority => 100, :iso_code => "NAD", :symbol_first => false, :html_entity => "$", :name => "Namibian Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :ngn => {:priority => 100, :iso_code => "NGN", :symbol_first => false, :html_entity => "&#x20A6;", :name => "Nigerian Naira", :symbol => "₦", :subunit => "Kobo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :nio => {:priority => 100, :iso_code => "NIO", :symbol_first => false, :html_entity => "", :name => "Nicaraguan Córdoba", :symbol => "C$", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :nok => {:priority => 100, :iso_code => "NOK", :symbol_first => true, :html_entity => "kr", :name => "Norwegian Krone", :symbol => "kr", :subunit => "Øre", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :npr => {:priority => 100, :iso_code => "NPR", :symbol_first => true, :html_entity => "&#x20A8;", :name => "Nepalese Rupee", :symbol => "₨", :subunit => "Paisa", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :nzd => {:priority => 100, :iso_code => "NZD", :symbol_first => true, :html_entity => "$", :name => "New Zealand Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :omr => {:priority => 100, :iso_code => "OMR", :symbol_first => true, :html_entity => "&#xFDFC;", :name => "Omani Rial", :symbol => "ر.ع.", :subunit => "Baisa", :subunit_to_unit => 1000, :decimal_mark => ".", :delimiter => ","},
        :pab => {:priority => 100, :iso_code => "PAB", :symbol_first => false, :html_entity => "", :name => "Panamanian Balboa", :symbol => "B/.", :subunit => "Centésimo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :pen => {:priority => 100, :iso_code => "PEN", :symbol_first => true, :html_entity => "S/.", :name => "Peruvian Nuevo Sol", :symbol => "S/.", :subunit => "Céntimo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :pgk => {:priority => 100, :iso_code => "PGK", :symbol_first => false, :html_entity => "", :name => "Papua New Guinean Kina", :symbol => "K", :subunit => "Toea", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :php => {:priority => 100, :iso_code => "PHP", :symbol_first => false, :html_entity => "&#x20B1;", :name => "Philippine Peso", :symbol => "₱", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :pkr => {:priority => 100, :iso_code => "PKR", :symbol_first => true, :html_entity => "&#x20A8;", :name => "Pakistani Rupee", :symbol => "₨", :subunit => "Paisa", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :pln => {:priority => 100, :iso_code => "PLN", :symbol_first => true, :html_entity => "", :name => "Polish Złoty", :symbol => "zł", :subunit => "Grosz", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :pyg => {:priority => 100, :iso_code => "PYG", :symbol_first => true, :html_entity => "&#x20B2;", :name => "Paraguayan Guaraní", :symbol => "₲", :subunit => "Céntimo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :qar => {:priority => 100, :iso_code => "QAR", :symbol_first => false, :html_entity => "&#xFDFC;", :name => "Qatari Riyal", :symbol => "ر.ق", :subunit => "Dirham", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :ron => {:priority => 100, :iso_code => "RON", :symbol_first => true, :html_entity => "", :name => "Romanian Leu", :symbol => "L", :subunit => "Ban", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :rsd => {:priority => 100, :iso_code => "RSD", :symbol_first => true, :html_entity => "", :name => "Serbian Dinar", :symbol => "din. or дин.", :subunit => "Para", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :rub => {:priority => 100, :iso_code => "RUB", :symbol_first => false, :html_entity => "&#x0440;&#x0443;&#x0431;", :name => "Russian Ruble", :symbol => "р.", :subunit => "Kopek", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :rwf => {:priority => 100, :iso_code => "RWF", :symbol_first => false, :html_entity => "", :name => "Rwandan Franc", :symbol => "Fr", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :sar => {:priority => 100, :iso_code => "SAR", :symbol_first => true, :html_entity => "&#xFDFC;", :name => "Saudi Riyal", :symbol => "ر.س", :subunit => "Hallallah", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :sbd => {:priority => 100, :iso_code => "SBD", :symbol_first => false, :html_entity => "$", :name => "Solomon Islands Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :scr => {:priority => 100, :iso_code => "SCR", :symbol_first => false, :html_entity => "&#x20A8;", :name => "Seychellois Rupee", :symbol => "₨", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :sdg => {:priority => 100, :iso_code => "SDG", :symbol_first => true, :html_entity => "", :name => "Sudanese Pound", :symbol => "£", :subunit => "Piastre", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :sek => {:priority => 100, :iso_code => "SEK", :symbol_first => true, :html_entity => "", :name => "Swedish Krona", :symbol => "kr", :subunit => "Öre", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :sgd => {:priority => 100, :iso_code => "SGD", :symbol_first => true, :html_entity => "$", :name => "Singapore Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :shp => {:priority => 100, :iso_code => "SHP", :symbol_first => false, :html_entity => "&#x00A3;", :name => "Saint Helenian Pound", :symbol => "£", :subunit => "Penny", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :skk => {:priority => 100, :iso_code => "SKK", :symbol_first => true, :html_entity => "", :name => "Slovak Koruna", :symbol => "Sk", :subunit => "Halier", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :sll => {:priority => 100, :iso_code => "SLL", :symbol_first => false, :html_entity => "", :name => "Sierra Leonean Leone", :symbol => "Le", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :sos => {:priority => 100, :iso_code => "SOS", :symbol_first => false, :html_entity => "", :name => "Somali Shilling", :symbol => "Sh", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :srd => {:priority => 100, :iso_code => "SRD", :symbol_first => false, :html_entity => "", :name => "Surinamese Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :std => {:priority => 100, :iso_code => "STD", :symbol_first => false, :html_entity => "", :name => "São Tomé and Príncipe Dobra", :symbol => "Db", :subunit => "Cêntimo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :svc => {:priority => 100, :iso_code => "SVC", :symbol_first => true, :html_entity => "&#x20A1;", :name => "Salvadoran Colón", :symbol => "₡", :subunit => "Centavo", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :syp => {:priority => 100, :iso_code => "SYP", :symbol_first => false, :html_entity => "&#x00A3;", :name => "Syrian Pound", :symbol => "£ or ل.س", :subunit => "Piastre", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :szl => {:priority => 100, :iso_code => "SZL", :symbol_first => true, :html_entity => "", :name => "Swazi Lilangeni", :symbol => "L", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :thb => {:priority => 100, :iso_code => "THB", :symbol_first => true, :html_entity => "&#x0E3F;", :name => "Thai Baht", :symbol => "฿", :subunit => "Satang", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :tjs => {:priority => 100, :iso_code => "TJS", :symbol_first => false, :html_entity => "", :name => "Tajikistani Somoni", :symbol => "ЅМ", :subunit => "Diram", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :tmm => {:priority => 100, :iso_code => "TMM", :symbol_first => false, :html_entity => "", :name => "Turkmenistani Manat", :symbol => "m", :subunit => "Tennesi", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :tnd => {:priority => 100, :iso_code => "TND", :symbol_first => false, :html_entity => "", :name => "Tunisian Dinar", :symbol => "د.ت", :subunit => "Millime", :subunit_to_unit => 1000, :decimal_mark => ".", :delimiter => ","},
        :top => {:priority => 100, :iso_code => "TOP", :symbol_first => true, :html_entity => "", :name => "Tongan Paʻanga", :symbol => "T$", :subunit => "Seniti", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :try => {:priority => 100, :iso_code => "TRY", :symbol_first => false, :html_entity => "", :name => "Turkish New Lira", :symbol => "YTL", :subunit => "New kuruş", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :ttd => {:priority => 100, :iso_code => "TTD", :symbol_first => false, :html_entity => "$", :name => "Trinidad and Tobago Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :twd => {:priority => 100, :iso_code => "TWD", :symbol_first => false, :html_entity => "$", :name => "New Taiwan Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :tzs => {:priority => 100, :iso_code => "TZS", :symbol_first => true, :html_entity => "", :name => "Tanzanian Shilling", :symbol => "Sh", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :uah => {:priority => 100, :iso_code => "UAH", :symbol_first => false, :html_entity => "&#x20B4", :name => "Ukrainian Hryvnia", :symbol => "₴", :subunit => "Kopiyka", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :ugx => {:priority => 100, :iso_code => "UGX", :symbol_first => false, :html_entity => "", :name => "Ugandan Shilling", :symbol => "Sh", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :usd => {:priority => 1,   :iso_code => "USD", :symbol_first => true, :html_entity => "$", :name => "United States Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :uyu => {:priority => 100, :iso_code => "UYU", :symbol_first => true, :html_entity => "&#x20B1;", :name => "Uruguayan Peso", :symbol => "$", :subunit => "Centésimo", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :uzs => {:priority => 100, :iso_code => "UZS", :symbol_first => false, :html_entity => "", :name => "Uzbekistani Som", :symbol => nil, :subunit => "Tiyin", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :vef => {:priority => 100, :iso_code => "VEF", :symbol_first => true, :html_entity => "", :name => "Venezuelan Bolívar", :symbol => "Bs F", :subunit => "Céntimo", :subunit_to_unit => 100, :decimal_mark => ",", :delimiter => "."},
        :vnd => {:priority => 100, :iso_code => "VND", :symbol_first => true, :html_entity => "&#x20AB;", :name => "Vietnamese Đồng", :symbol => "₫", :subunit => "Hào", :subunit_to_unit => 10, :decimal_mark => ",", :delimiter => "."},
        :vuv => {:priority => 100, :iso_code => "VUV", :symbol_first => true, :html_entity => "", :name => "Vanuatu Vatu", :symbol => "Vt", :subunit => nil, :subunit_to_unit => 1, :decimal_mark => ".", :delimiter => ","},
        :wst => {:priority => 100, :iso_code => "WST", :symbol_first => false, :html_entity => "", :name => "Samoan Tala", :symbol => "T", :subunit => "Sene", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :xaf => {:priority => 100, :iso_code => "XAF", :symbol_first => false, :html_entity => "", :name => "Central African Cfa Franc", :symbol => "Fr", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :xcd => {:priority => 100, :iso_code => "XCD", :symbol_first => true, :html_entity => "$", :name => "East Caribbean Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :xof => {:priority => 100, :iso_code => "XOF", :symbol_first => false, :html_entity => "", :name => "West African Cfa Franc", :symbol => "Fr", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :xpf => {:priority => 100, :iso_code => "XPF", :symbol_first => false, :html_entity => "", :name => "Cfp Franc", :symbol => "Fr", :subunit => "Centime", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :yer => {:priority => 100, :iso_code => "YER", :symbol_first => false, :html_entity => "&#xFDFC;", :name => "Yemeni Rial", :symbol => "﷼", :subunit => "Fils", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :zar => {:priority => 100, :iso_code => "ZAR", :symbol_first => true, :html_entity => "&#x0052;", :name => "South African Rand", :symbol => "R", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :zmk => {:priority => 100, :iso_code => "ZMK", :symbol_first => false, :html_entity => "", :name => "Zambian Kwacha", :symbol => "ZK", :subunit => "Ngwee", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
        :zwd => {:priority => 100, :iso_code => "ZWD", :symbol_first => true, :html_entity => "$", :name => "Zimbabwean Dollar", :symbol => "$", :subunit => "Cent", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},

        # aliases for BC with documentation before Currency
        :yen => {:priority => 100, :iso_code => "JPY", :symbol_first => true, :html_entity => "&#x00A5;", :name => "Japanese Yen", :symbol => "¥", :subunit => "Sen", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},

        # kept for backwards compatibility, real entry is :ghs
        :ghc => {:priority => 100, :iso_code => "GHS", :symbol_first => true, :html_entity => "&#x20B5;", :name => "Ghanaian Cedi", :symbol => "₵", :subunit => "Pesewa", :subunit_to_unit => 100, :decimal_mark => ".", :delimiter => ","},
    }

    # The symbol used to identify the currency, usually the lowercase
    # +iso_code+ attribute.
    #
    # @return [Symbol]
    attr_reader :id

    # A numerical value you can use to sort/group the currency list.
    #
    # @return [Integer]
    attr_reader :priority

    # The international 3-letter code as defined by the ISO 4217 standard.
    #
    # @return [String]
    attr_reader :iso_code

    # The currency name.
    #
    # @return [String]
    attr_reader :name

    # The currency symbol (UTF-8 encoded).
    #
    # @return [String]
    attr_reader :symbol

    # The html entity for the currency symbol
    #
    # @return [String]
    attr_reader :html_entity

    # The name of the fractional monetary unit.
    #
    # @return [String]
    attr_reader :subunit

    # The proportion between the unit and the subunit
    #
    # @return [Integer]
    attr_reader :subunit_to_unit

    # The decimal mark, or character used to separate the whole unit from the subunit.
    #
    # @return [String]
    attr_reader :decimal_mark
    alias :separator :decimal_mark

    # The character used to separate thousands grouping of the whole unit.
    #
    # @return [String]
    attr_reader :delimiter

    # Should the currency symbol precede the amount, or should it come after?
    #
    # @return [boolean]
    attr_reader :symbol_first

    def symbol_first?
      !!@symbol_first
    end

    # The number of decimal places needed.
    #
    # @return [Integer]`
    def decimal_places
      if subunit_to_unit == 1
        0
      elsif subunit_to_unit % 10 == 0
        Math.log10(subunit_to_unit).to_s.to_i
      else
        Math.log10(subunit_to_unit).to_s.to_i+1
      end
    end

    # Create a new +Currency+ object.
    #
    # @param [String, Symbol, #to_s] id Used to look into +TABLE+ and retrieve
    #  the applicable attributes.
    #
    # @return [Money::Currency]
    #
    # @example
    #   Money::Currency.new(:usd) #=> #<Money::Currency id: usd ...>
    def initialize(id)
      @id  = id.to_s.downcase.to_sym
      data = TABLE[@id] || raise(UnknownCurrency, "Unknown currency `#{id}'")
      data.each_pair do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end

    # Compares +self+ with +other_currency+ against the value of +priority+
    # attribute.
    #
    # @param [Money::Currency] other_currency The currency to compare to.
    #
    # @return [-1,0,1] -1 if less than, 0 is equal to, 1 if greater than
    #
    # @example
    #   c1 = Money::Currency.new(:usd)
    #   c2 = Money::Currency.new(:jpy)
    #   c1 <=> c2 #=> 1
    #   c2 <=> c1 #=> -1
    #   c1 <=> c1 #=> 0
    def <=>(other_currency)
      self.priority <=> other_currency.priority
    end

    # Compares +self+ with +other_currency+ and returns +true+ if the are the
    # same or if their +id+ attributes match.
    #
    # @param [Money::Currency] other_currency The currency to compare to.
    #
    # @return [Boolean]
    #
    # @example
    #   c1 = Money::Currency.new(:usd)
    #   c2 = Money::Currency.new(:jpy)
    #   c1 == c1 #=> true
    #   c1 == c2 #=> false
    def ==(other_currency)
      self.equal?(other_currency) ||
      self.id == other_currency.id
    end

    # Compares +self+ with +other_currency+ and returns +true+ if the are the
    # same or if their +id+ attributes match.
    #
    # @param [Money::Currency] other_currency The currency to compare to.
    #
    # @return [Boolean]
    #
    # @example
    #   c1 = Money::Currency.new(:usd)
    #   c2 = Money::Currency.new(:jpy)
    #   c1.eql? c1 #=> true
    #   c1.eql? c2 #=> false
    def eql?(other_currency)
      self == other_currency
    end

    # Returns a Fixnum hash value based on the +id+ attribute in order to use
    # functions like & (intersection), group_by, etc.
    #
    # @return [Fixnum]
    #
    # @example
    #   Money::Currency.new(:usd).hash #=> 428936
    def hash
      id.hash
    end

    # Returns a string representation corresponding to the upcase +id+
    # attribute.
    #
    # -–
    # DEV: id.to_s.upcase corresponds to iso_code but don't use ISO_CODE for consistency.
    #
    # @return [String]
    #
    # @example
    #   Money::Currency.new(:usd).to_s #=> "USD"
    #   Money::Currency.new(:eur).to_s #=> "EUR"
    def to_s
      id.to_s.upcase
    end

    # Returns a human readable representation.
    #
    # @return [String]
    #
    # @example
    #   Money::Currency.new(:usd) #=> #<Currency id: usd ...>
    def inspect
      "#<#{self.class.name} id: #{id}, #{instance_variables.reject{|i|i == '@id'}.collect{ |a| "#{a[1..-1]}: #{instance_variable_get(a)}"}.join(", ")}>"
    end

    # Class Methods
    class << self

      # Lookup a currency with given +id+ an returns a +Currency+ instance on
      # success, +nil+ otherwise.
      #
      # @param [String, Symbol, #to_s] id Used to look into +TABLE+ and
      # retrieve the applicable attributes.
      #
      # @return [Money::Currency]
      #
      # @example
      #   Money::Currency.find(:eur) #=> #<Money::Currency id: eur ...>
      #   Money::Currency.find(:foo) #=> nil
      def find(id)
        id = id.to_s.downcase.to_sym
        new(id) if self::TABLE[id]
      end

      # Wraps the object in a +Currency+ unless it's already a +Currency+
      # object.
      #
      # @param [Object] object The object to attempt and wrap as a +Currency+
      # object.
      #
      # @return [Money::Currency]
      #
      # @example
      #   c1 = Money::Currency.new(:usd)
      #   Money::Currency.wrap(nil)   #=> nil
      #   Money::Currency.wrap(c1)    #=> #<Money::Currency id: usd ...>
      #   Money::Currency.wrap("usd") #=> #<Money::Currency id: usd ...>
      def wrap(object)
        if object.nil?
          nil
        elsif object.is_a?(Currency)
          object
        else
          Currency.new(object)
        end
      end
    end
  end
end
