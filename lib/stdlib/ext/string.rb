class String
    alias old_memeber []

    def ord (index)
        self.old_memeber index
    end

    def get(index)
        self.scan(/./)[index]
    end

    def set(index,value)
        arr = self.scan(/./)
        arr[index] = value
        self.replace(arr.join)
        value
    end
end

