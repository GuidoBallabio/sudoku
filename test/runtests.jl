using Sudoku
using Test

@testset "io & setup" begin
    @test Set(Sudoku.setup.peers[CartesianIndex(1,1)]) ==  Set([ CartesianIndex(1, 4),
                                                         CartesianIndex(3, 2),
                                                         CartesianIndex(1, 6),
                                                         CartesianIndex(8, 1),
                                                         CartesianIndex(1, 5),
                                                         CartesianIndex(4, 1),
                                                         CartesianIndex(9, 1),
                                                         CartesianIndex(6, 1),
                                                         CartesianIndex(3, 3),
                                                         CartesianIndex(5, 1),
                                                         CartesianIndex(1, 2),
                                                         CartesianIndex(1, 7),
                                                         CartesianIndex(1, 3),
                                                         CartesianIndex(2, 2),
                                                         CartesianIndex(2, 3),
                                                         CartesianIndex(1, 9),
                                                         CartesianIndex(1, 8),
                                                         CartesianIndex(2, 1),
                                                         CartesianIndex(3, 1),
                                                         CartesianIndex(7, 1) ])
    file = "sudoku-hardest.txt"
    @test parse_all(file)[1] == ['8'  '5'  ' '  ' '  ' '  '2'  '4'  ' '  ' '
                                 '7'  '2'  ' '  ' '  ' '  ' '  ' '  ' '  '9'
                                 ' '  ' '  '4'  ' '  ' '  ' '  ' '  ' '  ' '
                                 ' '  ' '  ' '  '1'  ' '  '7'  ' '  ' '  '2'
                                 '3'  ' '  '5'  ' '  ' '  ' '  '9'  ' '  ' '
                                 ' '  '4'  ' '  ' '  ' '  ' '  ' '  ' '  ' '
                                 ' '  ' '  ' '  ' '  '8'  ' '  ' '  '7'  ' '
                                 ' '  '1'  '7'  ' '  ' '  ' '  ' '  ' '  ' '
                                 ' '  ' '  ' '  ' '  '3'  '6'  ' '  '4'  ' ']


    @test solve_all(file)[1] == ['8'  '5'  '9'  '6'  '1'  '2'  '4'  '3'  '7'
                                 '7'  '2'  '3'  '8'  '5'  '4'  '1'  '6'  '9'
                                 '1'  '6'  '4'  '3'  '7'  '9'  '5'  '2'  '8'
                                 '9'  '8'  '6'  '1'  '4'  '7'  '3'  '5'  '2'
                                 '3'  '7'  '5'  '2'  '6'  '8'  '9'  '1'  '4'
                                 '2'  '4'  '1'  '5'  '9'  '3'  '7'  '8'  '6'
                                 '4'  '3'  '2'  '9'  '8'  '1'  '6'  '7'  '5'
                                 '6'  '1'  '7'  '4'  '2'  '5'  '8'  '9'  '3'
                                 '5'  '9'  '8'  '7'  '3'  '6'  '2'  '4'  '1']

end
