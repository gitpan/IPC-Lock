use Test::More tests => 6;
BEGIN { use_ok('IPC::Lock::Memcached') };

my $object = IPC::Lock::Memcached->new({
    memcached_servers => ['localhost:11211'],
});

my $key = "$$.testing";
ok($object && ref $object && ref $object eq 'IPC::Lock::Memcached', 'instantiation');
ok($object->lock($key), "$key locked");
ok($object->memcached->get($key), "$key exists in memcached");
ok($object->unlock, "$key unlocked");
ok(!$object->memcached->get($key), "$key deleted from memcached");
