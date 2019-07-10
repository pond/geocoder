require 'geocoder/models/base'

module Geocoder
  module Model
    module ActiveRecord
      include Base

      ##
      # Set attribute names and include the Geocoder module.
      #
      def geocoded_by(address_attr, options = {}, &block)
        geocoder_init(
          :geocode       => true,
          :user_address  => address_attr,
          :latitude      => ActiveRecord::Base.connection.quote_column_name(latitude_attr),
          :longitude     => ActiveRecord::Base.connection.quote_column_name(longitude_attr),
          :geocode_block => block,
          :units         => options[:units],
          :method        => options[:method],
          :lookup        => options[:lookup],
          :language      => options[:language],
          :params        => options[:params]
        )
      end

      ##
      # Set attribute names and include the Geocoder module.
      #
      def reverse_geocoded_by(latitude_attr, longitude_attr, options = {}, &block)
        geocoder_init(
          :reverse_geocode => true,
          :fetched_address => options[:address] || :address,
          :latitude        => ActiveRecord::Base.connection.quote_column_name(latitude_attr),
          :longitude       => ActiveRecord::Base.connection.quote_column_name(longitude_attr),
          :reverse_block   => block,
          :units           => options[:units],
          :method          => options[:method],
          :lookup          => options[:lookup],
          :language        => options[:language],
          :params          => options[:params]
        )
      end


      private # --------------------------------------------------------------

      def geocoder_file_name;   "active_record"; end
      def geocoder_module_name; "ActiveRecord"; end
    end
  end
end
