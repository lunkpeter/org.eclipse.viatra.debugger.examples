package org.eclipse.incquery.examples.cps.viatradebugger.performance

import org.eclipse.emf.common.util.URI
import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.BasePerformanceTransformation
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.emf.runtime.tracer.traceexecutor.TraceExecutor
import org.eclipse.viatra.emf.runtime.transformation.eventdriven.ExecutionSchemaBuilder

class PerformanceTraceExecutorTransformation extends BasePerformanceTransformation{
	TraceExecutor executorAdapter
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	
	override createExecutionSchema() {
		executorAdapter = new TraceExecutor(URI.createURI("transformationtrace/trace.transformationtrace"));
        
        val executor = factory.createAdaptableExecutor()
                .setIncQueryEngine(engine)
                .addAdapter(executorAdapter)
                .build() as AdaptableExecutor;
		
		val ExecutionSchemaBuilder builder= new ExecutionSchemaBuilder()
			.setEngine(engine)
			.setExecutor(executor)
			.setConflictResolver(createConflictResolver)

		return builder.build()
	}
	
	override afterTransformationInit() {
		executorAdapter.setRules(transform.getTransformationRules());
	}
}