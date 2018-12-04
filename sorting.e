note
	description: "Summary description for {LOLA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SORTING

create
	make

feature
	make
	local
		i: INTEGER
		do
			create successor.make_empty
			successor.conservative_resize_with_default (create {LINKED_LIST[INTEGER]}.make,1,2000)
			from i:=1 until i=2001
			loop
				successor.force (create{LINKED_LIST[INTEGER]}.make, i)
				i:=i+1
			end
			create candidates.make
			create elements.make (1)
			create constraints.make (1)
			create index_list.make
			create base_stack.make
			create pred_count.make_empty
			create liste_index.make_empty
			create constraints_index.make_empty
			create sorted_list.make (0)
			create hash_list.make
		end


feature
	candidates: LINKED_QUEUE[INTEGER]
	liste_index: ARRAY[INTEGER]
	constraints_index: ARRAY[TUPLE[dom: INTEGER; sub: INTEGER]]
	hash_list: LINKED_LIST[INTEGER]
	elder: INTEGER
	pred_count: ARRAY[INTEGER]
	base_stack: LINKED_STACK [INTEGER]
	elements: ARRAYED_LIST [INTEGER]
	constraints: ARRAYED_LIST [TUPLE[ind: INTEGER; dep:INTEGER]]
	index_list: LINKED_STACK [INTEGER]
	successor: ARRAY[LINKED_LIST[INTEGER]]
	sorted_list: ARRAYED_LIST[INTEGER]
	freed: INTEGER
	next: INTEGER
feature
	do_process -- main process of sorting
		do
			next:=candidates.item
			sorted_list.extend (next)
			candidates.remove
			hash_list:= successor[next]
			from
				hash_list.start
			until
				hash_list.after
			loop
				freed:= hash_list.item
				pred_count[freed]:=pred_count[freed]-1
				if pred_count[freed]=0 then
					candidates.put(freed)
				end
				hash_list.forth
			end
			hash_list.wipe_out
		end
	set_candidates
		do
			across pred_count as i
			loop
				if i.item = 0 then
					candidates.put (i.cursor_index)
				end
			end
		end
	set_elements_index
		do
			across elements as i
			loop
				liste_index.enter (i.cursor_index, i.cursor_index)
			end
		end
	set_hash
		do
			across constraints as  i
			loop
				successor[i.item.ind].extend(i.item.dep)
			end
		end
--	set_constraints_index
--		do
--			across t_list as i
--			loop
--				constraints_index.enter ([], i.cursor_index)
	--		end
--		end
	set_pred_count
		do
			across constraints as f
				loop
					pred_count[f.item.dep]:=pred_count[f.item.dep]+1
				end
		end
	set_array(c: INTEGER;a: ARRAY[INTEGER])
		do
			a.make_filled (0, 1, c)
		end
	add_nr (x: INTEGER)
		do
			elements.extend (x)
		end
	add_tuple (y: TUPLE[ind: INTEGER; dep:INTEGER])
		do
			constraints.extend (y)
		end
	add_index (z: INTEGER)
		do
			index_list.extend (z)
		end

	remove_item (q: INTEGER) -- remove all items equal q (not used)
		do
			across elements as i
				loop
					if i.item = q then
						index_list.extend(i.cursor_index)
					end

				end
			from

			until
				index_list.is_empty
			loop
				elements.go_i_th (index_list.item)
				elements.remove
				index_list.remove

			end
		end

	remove_tuple (q: INTEGER)	-- Removes all tuples with dep = q (not used)
		do
			across constraints as i
				loop
					if i.item.dep = q then
						index_list.extend(i.cursor_index)
					end

				end
			from

			until
				index_list.is_empty
			loop
				constraints.go_i_th (index_list.item)
				constraints.remove
				index_list.remove

			end
		end


end
