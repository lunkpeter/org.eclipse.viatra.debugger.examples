package org.eclipse.incquery.examples.cps.viatradebugger

import org.eclipse.emf.common.util.URI
import org.eclipse.incquery.examples.cps.viatradebugger.example.InitializerComponent
import org.eclipse.incquery.examples.cps.viatradebugger.example.ViatraTransformation
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.emf.runtime.debug.configuration.ManualConflictResolverConfiguration
import org.eclipse.viatra.emf.runtime.tracer.tracecoder.TraceCoder
import org.junit.Test

class RunTraceCoderTransformation {
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	extension ViatraTransformation transformation
	
	@Test def void runViatraTraceCodeTransformation() {
		val init = new InitializerComponent()
		val cps2dep = init.loadModel("output/output1alt.cyberphysicalsystem")
		
		transformation = new ViatraTransformation(cps2dep)
		
		val coder = new TraceCoder(URI.createURI("transformationtrace/trace.transformationtrace"));
        val manualResolver = new ManualConflictResolverConfiguration
		
		 val executor = factory.createAdaptableExecutor()
                .setIncQueryEngine(engine)
                .addConfiguration(manualResolver)
                .addAdapter(coder)
                .build() as AdaptableExecutor
			
		transformation.setExecutor(executor).initialize()
		coder.setRules(transform.getTransformationRules())
		transformation.execute
	}
}
