package org.eclipse.incquery.examples.cps.viatradebugger.performance

import org.eclipse.emf.common.util.URI
import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.BasePerformanceTransformation
import org.eclipse.viatra.transformation.tracer.tracecoder.TraceCoder
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.transformation.runtime.emf.transformation.eventdriven.ExecutionSchemaBuilder

class PerformanceTraceCodeTransformation extends BasePerformanceTransformation{
	TraceCoder coder
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	
	override createExecutionSchema() {
		coder = new TraceCoder(URI.createURI("transformationtrace/trace.transformationtrace"));
		
		 val executor = factory.createAdaptableExecutor()
                .setQueryEngine(engine)
                .addAdapter(coder)
                .build() as AdaptableExecutor
		
		val ExecutionSchemaBuilder builder= new ExecutionSchemaBuilder()
			.setEngine(engine)
			.setExecutor(executor)
			.setConflictResolver(createConflictResolver)

		return builder.build()
	}
	
	override afterTransformationInit() {
		println(transform.getTransformationRules().keySet.size)
		coder.setRules(transform.getTransformationRules());
	}
}