package hello;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.slf4j.Marker;
import org.slf4j.MarkerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.util.MimeTypeUtils.APPLICATION_JSON_VALUE;

@Slf4j
@SpringBootApplication
@RestController
@RequestMapping(value = "/", produces = APPLICATION_JSON_VALUE)
public class Application {

    @GetMapping("")
    public String home() {
        log.info("Accessed root!");
        return "Welcome to the root!";
    }

    /**
     * Audit log
     *
     * @return
     */
    @GetMapping("/audit")
    public String audit() {
        auditLog("This is an Audit log");
        log.info("This is an application log");
        return "Welcome to audit log!";
    }

    private void auditLog(String message) {
        auditLog(message, null);
    }

    private void auditLog(String message, Map<String, String> map) {
        Map<String, String> ctxMap = Optional.ofNullable(map).orElseGet(HashMap::new);
        ctxMap.put("audit", "true");
        ctxMap.put("log_type", "audit");
        try {
            MDC.setContextMap(ctxMap);
            Marker marker = MarkerFactory.getMarker("audit_marker");
            log.info(marker, message);
        } finally {
            MDC.clear();
        }
    }

    @GetMapping("/greet/{name:.*}")
    public String greet(@PathVariable String name) {
        log.info("hello: " + name);
        auditLog("This is an Audit log - " + name);
        return "Hello " + name + "!";
    }

    @GetMapping("/exception")
    public String error() {
        log.info("Welcome to the exceptional world!");
        try {
            throw new RuntimeException("test exception log!");
        } catch (Exception e) {
            log.error("Throw an exception purposely here", e);
        }
        auditLog("This is an Audit log with exception", new HashMap<String, String>() {{
            put("exception_type", "runtime exception");
        }});
        return "Welcome to the exceptional world!";
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}
