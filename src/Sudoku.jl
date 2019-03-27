module Sudoku
export parse_all, solve_all, solve, parse_sudoku

    module io
    export parse_all, parse_sudoku

        function parse_sudoku(s::AbstractString)
            arrC = filter(x->!isspace(x), collect(s))
            grid = map(arrC) do c
                if c in "0."
                    ' '
                else
                    c
                end
            end
        grid = permutedims(reshape(grid, (9,9)), [2 1])
        end


        function read_all(file::AbstractString)
            games = read(file, String)
            split(games)
        end

        function parse_all(files...)
            [parse_sudoku(x) for f in files for x in read_all(f)]
        end
    end # module

    module setup
    export squares, peers, units

        squares = CartesianIndices((9,9))[:]
        
        box_from_square(index) = (index .- 1) .÷ 3 .+ 1

        function indexes_of_box(box)
            start = (box .- 1) .* 3 .+ 1
            CartesianIndex(start .- 1) .+ CartesianIndices((3,3))
        end

        get_box_peers(index) = indexes_of_box(box_from_square(index))

        function get_unitlist(index)
            row = [CartesianIndex((index[1], i)) for i in [1:9;]]
            col = [CartesianIndex((i, index[2])) for i in [1:9;]]
            box = get_box_peers(index)[:]
            [row, col, box]
        end

        function get_peers(index)
            [x for x in Set(vcat(get_unitlist(index)...)) if x != CartesianIndex(index)]
        end


        units = Dict([(x, get_unitlist(x.I)) for x in squares])
        peers = Dict([(x, get_peers(Tuple(x))) for x in squares])
    end # module

    module solver
    export solve, check_sol

        using ..setup: squares, units, peers

        include("solver.jl")

    end

    using .io: parse_all
    using .solver: solve, check_sol

    function solve_all(file)
        games = parse_all(file)
        check_sol.(solve.(games))
    end
end # module
