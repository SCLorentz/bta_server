javac -cp "server.jar" -d out \
	inject/Item.java # generated from the Item.patch

jar uf server.jar -C out net/minecraft/core/item/Item.class