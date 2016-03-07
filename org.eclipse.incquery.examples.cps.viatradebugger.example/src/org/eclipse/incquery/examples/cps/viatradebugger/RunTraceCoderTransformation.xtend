package org.eclipse.incquery.examples.cps.viatradebugger

import org.eclipse.emf.common.util.URI
import org.eclipse.incquery.examples.cps.viatradebugger.example.ViatraTransformation
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.transformation.debug.configuration.ManualConflictResolverConfiguration
import org.eclipse.viatra.transformation.tracer.tracecoder.TraceCoder
import org.junit.Test
import org.eclipse.incquery.examples.cps.viatradebugger.example.CPSModelInitializer

class RunTraceCoderTransformation {
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	extension ViatraTransformation transformation

	@Test def void runViatraTraceCodeTransformation() {
		val init = new CPSModelInitializer()
		val cps2dep = init.loadModel("output/example.cyberphysicalsystem")

		transformation = new ViatraTransformation(cps2dep)

		val coder = new TraceCoder(URI.createURI("transformationtrace/trace.transformationtrace"));
		val manualResolver = new ManualConflictResolverConfiguration

		val executor = factory.createAdaptableExecutor().setQueryEngine(engine).addConfiguration(manualResolver).
			addAdapter(coder).build() as AdaptableExecutor

		transformation.setExecutor(executor).initialize()
		coder.setRules(transform.getTransformationRules())
		transformation.execute
	}
}
