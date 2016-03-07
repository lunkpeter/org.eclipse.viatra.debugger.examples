package org.eclipse.incquery.examples.cps.viatradebugger;

import java.util.List;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.incquery.examples.cps.traceability.CPSToDeployment;
import org.eclipse.incquery.examples.cps.viatradebugger.example.InitializerComponent;
import org.eclipse.incquery.examples.cps.viatradebugger.metrics.ModelOnlyMetrics;
import org.eclipse.incquery.examples.cps.viatradebugger.performance.PerformanceAdaptableExecutorTransformation;
import org.eclipse.incquery.examples.cps.viatradebugger.performance.PerformanceConditionalDebugTransformation;
import org.eclipse.incquery.examples.cps.viatradebugger.performance.PerformanceControlTransformation;
import org.eclipse.incquery.examples.cps.viatradebugger.performance.PerformanceDebugTransformation;
import org.eclipse.incquery.examples.cps.viatradebugger.performance.PerformanceTraceCodeTransformation;
import org.eclipse.incquery.examples.cps.viatradebugger.performance.PerformanceTraceExecutorTransformation;
import org.eclipse.incquery.runtime.api.IncQueryEngine;
import org.eclipse.incquery.runtime.base.api.BaseIndexOptions;
import org.eclipse.incquery.runtime.emf.EMFScope;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runners.MethodSorters;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class RunPerformanceTests {
    static Map<String, List<Long>> results = Maps.newHashMap();
    static Integer size = 32;
    static Integer iterations = 10;

    @BeforeClass
    public static void init(){
        results.put("Control", Lists.newArrayList());
        results.put("Adapter", Lists.newArrayList());
        results.put("Debug", Lists.newArrayList());
        results.put("ConditionalDebugger", Lists.newArrayList());
        results.put("TraceCoder", Lists.newArrayList());
        results.put("TraceExecutor", Lists.newArrayList());
    }
    
    @Test
    @Ignore
    public void modelMetrics() {
        InitializerComponent init = new InitializerComponent();
        CPSToDeployment cps2dep = init.loadModel("output/output"+size+".cyberphysicalsystem");
        try {
            IncQueryEngine engine = IncQueryEngine.on(new EMFScope(cps2dep.getCps(), new BaseIndexOptions(true, true)));
            System.out.println("Number of types: "+ModelOnlyMetrics.calcCountTypes(engine));
            System.out.println("Number of elements: "+ModelOnlyMetrics.calcCountNodes(engine));
            System.out.println("Number of ereferences: "+ModelOnlyMetrics.calcCountEdges(engine));
            System.out.println("AVG in ref: "+ModelOnlyMetrics.calcAverageEReferenceDegree(engine, true));
            System.out.println("AVG out ref: "+ModelOnlyMetrics.calcAverageEReferenceDegree(engine, false));
        } catch (Exception e) {
            System.out.println("Error");
            e.printStackTrace();
        }
    }
    
    @Test
    @Ignore
    public void metaModelMetrics() {
        // Obtain a new resource set
        ResourceSet resSet = new ResourceSetImpl();
        // create a resource
        Resource cpsRes = resSet.getResource(URI
                .createURI("output/model.ecore"), true);
        EObject cps = cpsRes.getContents().get(0);
        
        try {
            IncQueryEngine engine = IncQueryEngine.on(new EMFScope(cps, new BaseIndexOptions(true, true)));
            System.out.println("Number of types: "+ModelOnlyMetrics.calcCountTypes(engine));
            System.out.println("Number of elements: "+ModelOnlyMetrics.calcCountNodes(engine));
            System.out.println("Number of ereferences: "+ModelOnlyMetrics.calcCountEdges(engine));
            System.out.println("AVG in ref: "+ModelOnlyMetrics.calcAverageEReferenceDegree(engine, true));
            System.out.println("AVG out ref: "+ModelOnlyMetrics.calcAverageEReferenceDegree(engine, false));
        } catch (Exception e) {
            System.out.println("Error");
            e.printStackTrace();
        }
    }
    
    
    @Test
    public void initialize() {
        for(int i =0; i<5; i++){
            InitializerComponent init = new InitializerComponent();
            CPSToDeployment cps2dep = init.loadModel("output/output1.cyberphysicalsystem");
            PerformanceControlTransformation transformation = new PerformanceControlTransformation();
            transformation.initialize(cps2dep);
            transformation.dispose();
        }
    }
    
    @Test
    //@Ignore
    public void runControlTransformation() {
        for(int i =0; i<iterations; i++){
            InitializerComponent init = new InitializerComponent();
            CPSToDeployment cps2dep = init.loadModel("output/output"+size+".cyberphysicalsystem");
            Long start = System.nanoTime();
            PerformanceControlTransformation transformation = new PerformanceControlTransformation();
            transformation.initialize(cps2dep);
            
            results.get("Control").add(System.nanoTime()-start);
            transformation.dispose();
        }
    }
    
    @Test
    @Ignore
    public void runAdapterTransformation() {
        for(int i =0; i<iterations; i++){
            InitializerComponent init = new InitializerComponent();
            CPSToDeployment cps2dep = init.loadModel("output/output"+size+".cyberphysicalsystem");
            Long start = System.nanoTime();
            PerformanceAdaptableExecutorTransformation transformation = new PerformanceAdaptableExecutorTransformation();
            transformation.initialize(cps2dep);

            results.get("Adapter").add(System.nanoTime()-start);
            transformation.dispose();
        }
        
    }
    
    
    @Test
    @Ignore
    public void runDebugTransformation() {
        for(int i =0; i<iterations; i++){
            InitializerComponent init = new InitializerComponent();
            CPSToDeployment cps2dep = init.loadModel("output/output"+size+".cyberphysicalsystem");
            Long start = System.nanoTime();
            PerformanceDebugTransformation transformation = new PerformanceDebugTransformation();
            transformation.initialize(cps2dep);

            results.get("Debug").add(System.nanoTime()-start);
            transformation.dispose();
        }
        
    }
    
    @Test
    @Ignore
    public void runConditionalDebugTransformation() {
        for(int i =0; i<iterations; i++){
            InitializerComponent init = new InitializerComponent();
            CPSToDeployment cps2dep = init.loadModel("output/output"+size+".cyberphysicalsystem");
            Long start = System.nanoTime();
            PerformanceConditionalDebugTransformation transformation = new PerformanceConditionalDebugTransformation();
            transformation.initialize(cps2dep);
            
            results.get("ConditionalDebugger").add(System.nanoTime()-start);
            transformation.dispose();
        }
        
    }
    
    @Test
    @Ignore
    public void runTracerTransformation() {
        for(int i =0; i<iterations; i++){
            InitializerComponent init = new InitializerComponent();
            CPSToDeployment cps2dep = init.loadModel("output/output"+size+".cyberphysicalsystem");
            Long start = System.nanoTime();
            PerformanceTraceCodeTransformation transformation = new PerformanceTraceCodeTransformation();
            transformation.initialize(cps2dep);
            
            results.get("TraceCoder").add(System.nanoTime()-start);
            transformation.dispose();
           
            
            start = System.nanoTime();
            PerformanceTraceExecutorTransformation executor = new PerformanceTraceExecutorTransformation();
            executor.initialize(cps2dep);
            
            results.get("TraceExecutor").add(System.nanoTime()-start);
            executor.dispose();
            
        }
      
    }
       

    
    @AfterClass
    public static void printResults(){
        for(String s : results.keySet()){
            String row = s+'\t';
            for(Long l : results.get(s)){
                row+=(l+"\t");
            }
            System.out.println(row);
        }
    }
    

    
}
