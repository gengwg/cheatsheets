gnu make relies on last modification time;
buck uses rule keys, sha-1 hash.

abi rule keys:
java don't need rebuild as long as the public abi doesn't change.

global build cache.

all repository maintain a 'warm' bookmark, where artifacts are known to the cache.

'stable' is only advanced when a build is successful; 'warm' is advanced when things are populated in cache.
