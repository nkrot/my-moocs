#!/usr/bin/ruby

require 'fd'
require 'test/unit'

class TestFD < Test::Unit::TestCase

  #
  # quiz 1
  #
  def test_1
    # Consider relation R(A,B,C,D,E) with functional dependencies:
    fds = [
      FD.new(["A","B"], "C"),
      FD.new("C", "D"),
      FD.new(["B","D"], "E")
    ]

    fda = FD::Analyser.new(fds)

    # Which of the following sets of attributes does not functionally determine E?
    assert  fda.possible?(FD.new(["A","B","C"], "E"))
    assert  fda.possible?(FD.new(["A","B"],     "E"))
    assert  fda.possible?(FD.new(["B","C"],     "E"))
    assert !fda.possible?(FD.new(["A","D"],     "E"))
  end

  def test_2
    # Consider relation R(A,B,C,D,E)
    rel = ["A","B","C","D","E"]
    # with functional dependencies:
    fds = [
           FD.new("D", "C"),
           FD.new(["C","E"], "A"),
           FD.new("D", "A"),
           FD.new(["A","E"], "D")
          ]

    fda = FD::Analyser.new(fds)

    # which of the following if the key of <rel>
    assert !fda.possible?(FD.new(["C","E"],      rel)) # non-key
    assert  fda.possible?(FD.new(["B", "D","E"], rel)) # key
    assert !fda.possible?(FD.new(["B", "D"],     rel)) # non-key
    assert !fda.possible?(FD.new(["C", "D","E"], rel)) # non-key
  end

  def test_3
    # the relation <rel>
    rel = ["A","B","C","D","E","F","G"]
    # satisfies the functional dependencies
    fds = [
           FD.new("A", "B"),
           FD.new(["C","H"], "A"),
           FD.new("B", "E"),
           FD.new(["B","D"], "C"),
           FD.new(["E","G"], "H"),
           FD.new(["D","E"], "F")
          ]

    fda = FD::Analyser.new(fds)

    rel = ["A","B","C","D","E","F","G"]

    # which of the following is also guaranteed to be satisfied by <rel>
    assert !fda.possible?(FD.new(["B","C","D"], ["F","H"]))
    assert !fda.possible?(FD.new(["A","D","E"], ["C","H"]))
    assert  fda.possible?(FD.new(["B","E","D"], ["C","F"])) # yes
    assert !fda.possible?(FD.new(["B","F","G"], ["A","E"]))
  end

  def test_4
    # Consider relation R(A,B,C,D,E,F)
    rel = ["A","B","C","D","E","F"]
    # with functional dependencies:
    fds = [
           FD.new(["C","D","E"], "B"),
           FD.new(["A","C","D"], "F"),
           FD.new(["B","E","F"], "C"),
           FD.new("B", "D")
          ]

    fda = FD::Analyser.new(fds)

    # Which of the following is a key?
    assert !fda.possible?(FD.new(["A","D","E","F"], rel)) # non-key
    assert  fda.possible?(FD.new(["A","C","D","E"], rel)) # key
    assert !fda.possible?(FD.new(["A","B","D","F"], rel)) # non-key
    assert !fda.possible?(FD.new(["B","D","F"],     rel)) # non-key

  end

  def test_5
    # Consider relation R(A,B,C,D,E,F,G)
    rel = ["A","B","C","D","E","F","G"]
    # with functional dependencies:
    fds = [
           FD.new(["A","B"], "C"),
           FD.new(["C","D"], "E"),
           FD.new(["E","F"], "G"),
           FD.new(["F","G"], "E"),
           FD.new(["D","E"], "C"),
           FD.new(["B","C"], "A"),
          ]

    fda = FD::Analyser.new(fds)

    # Which of the following is a key?
    assert !fda.possible?(FD.new(["A","D","F","G"], rel)) # non-key
    assert !fda.possible?(FD.new(["B","D","E","G"], rel)) # non-key
    assert  fda.possible?(FD.new(["B","C","D","F"], rel)) # key
    assert !fda.possible?(FD.new(["B","C","D","E"], rel)) # non-key
  end

  def test_6
    # Let relation R(A,B,C,D,E)
    rel = ["A","B","C","D","E"]
    # satisfy the following functional dependencies:
    fds = [
           FD.new(["A","B"], "C"),
           FD.new(["B","C"], "D"),
           FD.new(["C","D"], "E"),
           FD.new(["D","E"], "C"),
           FD.new(["A","E"], "B"),
          ]

    fda = FD::Analyser.new(fds)

    # Which of the following FDs is also guaranteed to be satisfied by R?
    assert  fda.possible?(FD.new(["A","C","E"], "D")) # this one
    assert !fda.possible?(FD.new(["A","C"],     "B"))
    assert !fda.possible?(FD.new("A",           "B"))
    assert !fda.possible?(FD.new(["A","D"],     "B"))
  end


  # TODO: not done
  def test_7
    # Let relation R(A,B,C,D)
    rel = ["A","B","C","D"]
    # satisfy the following functional dependencies.
    # Call this set S1.
    s1 = [ FD.new("A", "B"), FD.new("B", "C"), FD.new("C", "A") ]

    fda = FD::Analyser.new

    # A different set S2 of functional dependencies is equivalent to S1 if exactly the same FDs follow from S1 and S2.

    # Which of the following sets of FDs is equivalent to the set above?
    s2_1 = [ FD.new("A", ["B","C"]), FD.new("B", ["A","C"]), FD.new("C", ["A","B"]) ]
    assert_equal fda.merge(s1), fda.merge(s2_1)

    s2_2 = [ FD.new("B", ["A","C"]), FD.new("C", ["A","B"]) ]
    assert_equal fda.merge(s1), fda.merge(s2_2)

    s2_3 = [ FD.new("A", "B"), FD.new("B", "A"), FD.new("B", "C") ]
    assert_equal fda.merge(s1), fda.merge(s2_3)

    s2_4 = [ FD.new("A", ["B","C"]), FD.new("B", ["A","C"]) ]
    assert_equal fda.merge(s1), fda.merge(s2_4)

  end

end
