static def splitRucks(rucks) {
    def size = rucks.size()
    def mid = (int) (size / 2)
    [rucks.substring(0, mid), rucks.substring(mid, size)]
}

static def misPacked(left, right) {
    def all = left.findAll { right.indexOf(it) >= 0 }
    if (all.size() > 0) {
        return all.first()
    }
}


static void main(String[] args) {
    def priorities = ('a'..'z').toList()
    priorities.addAll('A'..'Z')

//    def packing = new File('resources/packing_test.txt')
    def packing = new File('resources/packing.txt')
    def sum = 0
    packing.eachLine {
        def split = splitRucks(it)
        def item = misPacked(split[0], split[1])
        def priority = priorities.indexOf(item) + 1
        sum += priority
    }
    println sum

    def badgeSum = 0
    def badgeRucks = []
    def groups = 0;
    packing.eachLine {
        badgeRucks.add it
        if (badgeRucks.size() ==3) {
            def badge = (
                    (badgeRucks[0].findAll {
                        badgeRucks[1].indexOf(it) >= 0
                    }).findAll { itt ->
                        badgeRucks[2].indexOf(itt) >= 0
                    }).unique()[0]
            def badgePriority = priorities.indexOf(badge) + 1
            badgeSum += badgePriority
            badgeRucks.clear()
        }
    }
    println badgeSum
}

