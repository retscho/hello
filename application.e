note
	description: "Try application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION


create
	make

feature
	p: SORTING
	next: INTEGER
	freed: INTEGER

feature {NONE} -- Initialization

	make
		do
			create p.make
			p.add_nr (1)
			p.add_nr (2)
			p.add_nr (3)
			p.add_nr (4)


			p.add_tuple ([1 ,2])
			p.add_tuple ([1 ,4])
			p.add_tuple ([2 ,4])
			p.add_tuple ([3 ,4])


			p.set_array (p.elements.count, p.pred_count) -- Array with n zeros

			p.set_pred_count -- fill array with pred counter

			p.successor.make_filled (p.hash_list, 1, p.elements.count) -- Array with n lists

		--	p.set_elements_index (NOCH AUSSTEHEND!)

		-- p.set_constraints_index (NOCH AUSSTEHEND!)

			p.set_hash --fill successor "hashtable"

			p.set_candidates -- fill candidates with pred_count = 0

			from --main sorting

			until
				p.candidates.is_empty
			loop
				p.do_process
			end

			print("Elements: ")
			across p.elements as i
			loop
				print(p.elements[i.cursor_index].out+" ")
			end



			io.new_line
			print("Sorted List: ")
			across p.sorted_list as i
			loop
				print(p.sorted_list[i.cursor_index].out+" ")
			end

			io.new_line

			print("Pred_count: ")
			across p.pred_count as i
			loop
				print(p.pred_count[i.cursor_index].out+" ")
			end

		end

end

