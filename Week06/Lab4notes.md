# Lab 4 Notes — Part 4: Foreign Key Constraints & Deletion Errors

When I tried deleting the Library and Information Science department in Part 4, MySQL threw **Error 1451** (*Cannot delete or update a parent row: a foreign key constraint fails*). It basically refused to let me do it because there was still a student record (`20239999`) tied to that department—MySQL protects its data relationships so you don't end up with orphaned rows pointing to nothing. 

To fix it, I first had to run an `UPDATE` statement to move that student over to Software Engineering. Once they weren't linked to it anymore, the delete command finally went through. 

Another way we could have handled this is by adding `ON DELETE CASCADE` when creating the foreign key. That way, deleting a department would automatically handle the connected students without needing a manual update first. (Or, as a quick workaround during testing, you can temporarily turn off foreign key checks with `SET FOREIGN_KEY_CHECKS = 0;`, though that's usually not recommended for real-world apps).