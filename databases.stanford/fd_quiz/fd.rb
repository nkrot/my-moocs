
# functional dependencies
class FD

  attr_reader :src, :trg

  def initialize(src, trg)
    # TODO: what are the correct names for the components of the logical implication?
    @src = src.is_a?(Array) ? src.dup : [ src ]
    @trg = trg.is_a?(Array) ? trg.dup : [ trg ]
  end

  def dup
    Marshal.load(Marshal.dump(self))
  end

  def all
    @src + @trg
  end

  def to_s
    "(#{@src.join(",")}) --> (#{@trg.join(",")})"
  end
  class Analyser

    def initialize(fds=nil)
      @fds = fds  if fds
    end

    # ofd - other FD
    def possible?(_ofd)
      ofd = _ofd.dup
      
      changed = true
      while changed
        changed = false
        @fds.each do |gfd| # given fd
          if (gfd.src - ofd.src).empty? && !(gfd.all - ofd.src).empty?
            ofd.src.concat gfd.trg
            changed = true
          end
        end
      end

      (ofd.trg - ofd.src).empty?
    end

    # join all fds into a relation, if possible
    # TODO: what if there are multiple resulting relations?
    def merge(fds)
      fds = fds.dup
      rel = fds.shift

      changed = true
      while changed
        changed = false
        fds.each_index do |i|
          if ...
        end
      end
    end
  end
end
