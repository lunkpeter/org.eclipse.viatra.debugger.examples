package org.eclipse.incquery.examples.cps.viatradebugger

import org.eclipse.emf.common.util.URI
import org.eclipse.incquery.examples.cps.viatradebugger.example.ViatraTransformation
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.transformation.tracer.traceexecutor.TraceExecutor
import org.junit.Test
import org.eclipse.incquery.examples.cps.viatradebugger.example.CPSModelInitializer

class RunTraceExecutorTransformation {
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	extension ViatraTransformation transformation
	
	@Test def void runViatraTraceExecutorTransformation() {
		val init = new CPSModelInitializer()
		val cps2dep = init.loadModel("output/example.cyberphysicalsystem")
		
		transformation = new ViatraTransformation(cps2dep)
		
		val executorAdapter = new TraceExecutor(URI.createURI("transformationtrace/trace.transformationtrace"));
        
        val executor = factory.createAdaptableExecutor()
                .setQueryEngine(engine)
                .addAdapter(executorAdapter)
                .build() as AdaptableExecutor;
			
		transformation.setExecutor(executor).initialize()
		executorAdapter.setRules(transform.getTransformationRules())
		transformation.execute
	}
}
