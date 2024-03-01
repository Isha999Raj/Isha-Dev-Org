public with sharing class FutureMethod2 {
    public FutureMethod2() {
        takeShower();
        haveBreakFast();
        carSevicing();
        office();

    }

    public static void takeShower(){

        system.debug('I am taking shower');

    }

    public static void haveBreakFast(){

        system.debug('Iam having my breakfast');

    }

    @future
    public static void carSevicing(){

        system.debug('Car is being repaired');

    }

    public static void office(){

        system.debug('I am in office');

    }
}