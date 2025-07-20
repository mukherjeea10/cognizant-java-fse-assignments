package com.cognizant.account;

import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
public class AccountController {
    @GetMapping("/accounts/{number}")
    public Map<String, Object> getAccount(@PathVariable String number) {
        return Map.of("number", number, "type", "savings", "balance", 234343);
    }
}
