# remove_unknowns
Minetestmod to remove unknown nodes in Mass

<br>
![Screenshot 1](textures/screenshot_2.jpg)
<br>

## Description
Remove unknowns is a small mod for minetest, to clean a world from unknown nodes.
Everbody knows the scenario, a mod on your game gives up to work and you have to
remove it from your minetest world.

Often you see after the remove of this world the feared "UNKOWN NODE"s. Sometimes
they are in Blue, sometimes they are in red, but doesn't matter what color they have,
they are unwanted.

What now to do? In Minetest itself isn't a function to remove all this blocks from the world. This has a
good reason why, because, if you temporarly remove the mod and install it a small time later again, the 
blocks aren't unknown and you have lost nothing.

The  MT-Engine itself don't know, is this a really unkown block or is it only temporarly unknown, so is the
better way to not touch this blocks.

But whats now, the mod will not more installed agains? The blocks are here and should be removed from the world.
Of course, there exists some mods to remove this blocks, but, either they are fast and remove sometimes not all blocks or they are slow, costs some ressources for the server but cleans the world as best.

An alias to this blocks could also be a solution, but if you forget to set an alias to some of these blocks, you
have to insert the block in your list of alias and have to restart the server.

A Problem, some solutions, but now, there comes a new solution: remove_unknowns.

## remove_unknowns

is a little mod which inserts a new chatcommand named: /ru <Unknown Node> for remove unknowns.
This command tries to swap all "Unknown Nodenames" to air in an given Radius.

/ru show_radius shows you the current radius.
/ru set_radius set's a new radius. Values between 1 and 75 possible. Don't try to set it higher, the mod will not work.
/ru version shows you  the current version of remove unknowns.

## For Admins

This should be a little and fast help for you, to remove fast unknown nodes, without to restart the server.
Also, the command brings the privileg unknown_killer, so you can grant to execute the command to player of your trust.
Because, the mod can removes unkown blocks, they have names like existing blocks. In  Fact, in a time they were existings blocks. So you or a player can remove valid blocks too, so please take care.
There are a second function, with /ru unknown_node node, you can replace unknown_nodes to node.
I do not take any responsibility in case of destruction of a building or world.

## License

GPL 3.0

## Depends

nothing
