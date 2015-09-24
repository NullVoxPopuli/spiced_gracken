module SpicedGracken
  module Config
    # maintains the list of servers while the client is running
    class ActiveServerList
      attr_accessor :_list

      delegate :count, to: :_list
      delegate :first, to: :_list
      delegate :last, to: :_list

      def initialize
        servers = SpicedGracken.server_list.as_entries
        self._list = servers
      end

      def clear!
        self._list ||= []
        self._list.clear
      end

      def remove(address: nil, alias_name: nil, uid: nil)
        entry = contains?(address: address, alias_name: alias_name, uid: uid)
        _list.delete(entry) if entry
      end

      def remove_by(field, value)
        case field
        when 'address'
          remove(address: value)
        when 'alias'
          remove(alias: value)
        when 'uid'
          remove(uid: value)
        end
      end

      def add(address: nil, alias_name: nil, uid: nil, public_key: nil, entry: nil)
        if contains?(uid: uid)
          update(uid, address: address, alias_name: alias_name)
        else
          entry = Entry.new(
            alias_name: alias_name,
            address: address,
            uid: uid,
            public_key: public_key
          ) unless entry

          _list << entry
        end
      end

      def update(uid, address: nil, alias_name: nil)
        entry = find_by_uid(uid)

        entry.address = address if address
        entry.alias_name = alias_name if alias_name
      end

      def find_by_uid(uid)
        _list.find { |l| l.uid == uid }
      end

      def all
        as_array
      end

      def as_array
        _list
      end

      def contains?(alias_name: nil, address: nil, uid: nil)
        _list.each do |entry|
          found = (
            (alias_name && entry.alias_name == alias_name) ||
            (address && entry.address == address) ||
            (uid && entry.uid == uid)
          )

          return entry if found
        end

        nil # not found
      end

      alias_method :find, :contains?

      def display_addresses
        _list.each do |entry|
          puts "#{entry.alias_name}@#{entry.address}".colorize(:light_black)
        end
      end

      def who
        puts _list.map{ |e| e.alias_name }.join(', ').colorize(:light_black)
      end
    end
  end
end
