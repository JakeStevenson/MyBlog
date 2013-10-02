---
title: Resolving Arrays In TinyIOC
author: Jake
date: 2013-09-27
template: article.jade
---

Well if I'm going to be writing about software development, I better actually get to some technical stuff.

We've been using NancyFX to create a pretty quick and easy API wrapper around a lot of our business logic.  By default, NancyFX uses TinyIOC as an IOC contaner, and it's pretty nice.  It's very simple and it does basic auto-registration of all the classes inside.  

Most of our products use Windsor as the container. I'd considered doing the work to make Windsor the container in our NancyFX API project, but decided I shouldn't have to.  It seems the code should be container-agnostic and it shouldn't really matter what container we use for a particular output.  And for 95% of the stuff I was right.

But we did hit a snag.  Some of our services depended on resolving an array of dependencies.  Something like this:

    public class SomeService
     {
       private ISomeInterface _dependencies{get;set;}
       public SomeService(ISomeInterface[] dependencies)
       {
         _depencencies = dependencies; 
       }
    
       public void DoSomething()
       {
         //Loop through the dependencies doing something with each of them
       }
    }

Windsor has a subresolver that allows this pattern, resolving arrays instead of just single classes.  Just do `container.Kernel.Resolver.AddSubResolver(new ArrayResolver(container.Kernel)` (what a mouthful).  But TinyIOC didn't do this.  

But TinyIOC does let you register factories as anonymous functions.  This was key to letting it resolve the array.  I can't do it automatically for any array of types, but I was able to do a simple one for this:

    container.Register<ISomeInterface[]>((c, p) =>
    {
        //Assuming all implementations come from the same assembly as the interface itself
        var allOfSomeInterface  = (from t in Assembly.GetAssembly(typeof (ISomeInterface)).GetTypes()
            where t.GetInterfaces().Contains(typeof (ISomeInterface))
            select t).ToArray();
        return allOfSomeInterface.Select(implementation => (ISomeInterface) container.Resolve(implementation)).ToArray();
    });

Kinda ugly, but also seems to make sense to me.  If I want to resolve all types matching the interface, I first use reflection to discover those types, then resolve each of those implementations from the container and return an array of them.
